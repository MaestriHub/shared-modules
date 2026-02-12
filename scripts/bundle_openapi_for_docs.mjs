#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { execSync } from 'node:child_process';

const root = process.cwd();
const openapiDir = path.join(root, 'docs', 'openapi');
const splitDir = path.join(openapiDir, 'split');
const outDir = path.join(openapiDir, 'dist');
const outPath = path.join(outDir, 'maetry-openapi-docs-3.2.yaml');

const yamlToObject = (yamlContent) => {
  const json = execSync(
    "ruby -ryaml -rjson -e 'obj=YAML.safe_load(STDIN.read, aliases: true); puts JSON.generate(obj)'",
    { input: yamlContent }
  ).toString();
  return JSON.parse(json);
};

const objectToYaml = (obj) => {
  const json = JSON.stringify(obj);
  return execSync(
    "ruby -rjson -ryaml -e 'obj=JSON.parse(STDIN.read); puts YAML.dump(obj)'",
    { input: json }
  ).toString();
};

const stable = (value) => JSON.stringify(value);

const mergeByKey = (target, incoming, section) => {
  Object.entries(incoming ?? {}).forEach(([key, value]) => {
    if (!(key in target)) {
      target[key] = value;
      return;
    }
    if (stable(target[key]) !== stable(value)) {
      throw new Error(`Conflict in ${section}: ${key}`);
    }
  });
};

if (!fs.existsSync(splitDir)) {
  throw new Error(`Split directory not found: ${splitDir}`);
}

const splitFiles = fs.readdirSync(splitDir)
  .filter((name) => name.endsWith('-3.2.yaml'))
  .sort();

if (splitFiles.length === 0) {
  throw new Error(`No split specs found in ${splitDir}`);
}

const specs = splitFiles.map((name) => {
  const fullPath = path.join(splitDir, name);
  const content = fs.readFileSync(fullPath, 'utf8');
  return { name, doc: yamlToObject(content) };
});

const first = specs[0].doc;
const bundled = {
  // Keep bundled docs spec on 3.1 for broader viewer/tool compatibility.
  openapi: '3.1.0',
  info: first.info ?? { title: 'Maetry API', version: '1.0.0' },
  servers: first.servers ?? [],
  paths: {},
  components: {},
  tags: [],
};

const tagSet = new Set();

specs.forEach(({ doc }) => {
  mergeByKey(bundled.paths, doc.paths ?? {}, 'paths');

  Object.entries(doc.components ?? {}).forEach(([section, sectionItems]) => {
    bundled.components[section] = bundled.components[section] ?? {};
    mergeByKey(bundled.components[section], sectionItems ?? {}, `components.${section}`);
  });

  (doc.tags ?? []).forEach((tag) => {
    if (!tag || typeof tag.name !== 'string') return;
    if (tagSet.has(tag.name)) return;
    tagSet.add(tag.name);
    bundled.tags.push(tag);
  });
});

bundled.tags.sort((a, b) => String(a.name).localeCompare(String(b.name)));

fs.mkdirSync(outDir, { recursive: true });
fs.writeFileSync(outPath, objectToYaml(bundled));
console.log(`Bundled ${splitFiles.length} specs -> ${outPath}`);
