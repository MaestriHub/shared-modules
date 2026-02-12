#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { execFileSync } from 'node:child_process';

const cwd = process.cwd();

const parseArgs = (argv) => {
  const out = {
    old: '',
    new: '',
    versionsFile: 'modules/sdk-versions.json',
    noChange: 'none',
    write: false,
  };

  for (let i = 0; i < argv.length; i += 1) {
    const a = argv[i];
    if (a === '--old') out.old = argv[++i] ?? '';
    else if (a === '--new') out.new = argv[++i] ?? '';
    else if (a === '--versions-file') out.versionsFile = argv[++i] ?? out.versionsFile;
    else if (a === '--no-change') out.noChange = argv[++i] ?? out.noChange;
    else if (a === '--write') out.write = true;
  }

  return out;
};

const fail = (msg) => {
  console.error(msg);
  process.exit(1);
};

const isSemver = (v) => /^\d+\.\d+\.\d+$/.test(v);

const bumpSemver = (version, kind) => {
  const [maj, min, pat] = version.split('.').map((n) => Number(n));
  if (kind === 'major') return `${maj + 1}.0.0`;
  if (kind === 'minor') return `${maj}.${min + 1}.0`;
  if (kind === 'patch') return `${maj}.${min}.${pat + 1}`;
  return version;
};

const sumChanges = (reportSummary) => {
  let totalChanges = 0;
  let breakingChanges = 0;

  if (!reportSummary || typeof reportSummary !== 'object') {
    return { totalChanges, breakingChanges };
  }

  Object.values(reportSummary).forEach((section) => {
    if (!section || typeof section !== 'object') return;
    totalChanges += Number(section.totalChanges ?? 0);
    breakingChanges += Number(section.breakingChanges ?? 0);
  });

  return { totalChanges, breakingChanges };
};

const args = parseArgs(process.argv.slice(2));

if (!args.old || !args.new) {
  fail('Usage: node scripts/semver_bump_from_openapi_diff.mjs --old <oldSpec> --new <newSpec> [--write] [--versions-file modules/sdk-versions.json] [--no-change none|patch]');
}

if (!['none', 'patch'].includes(args.noChange)) {
  fail('--no-change must be one of: none, patch');
}

const oldPath = path.resolve(cwd, args.old);
const newPath = path.resolve(cwd, args.new);
const versionsPath = path.resolve(cwd, args.versionsFile);

if (!fs.existsSync(oldPath)) fail(`Old spec not found: ${oldPath}`);
if (!fs.existsSync(newPath)) fail(`New spec not found: ${newPath}`);
if (!fs.existsSync(versionsPath)) fail(`Versions file not found: ${versionsPath}`);

let reportRaw = '';
try {
  reportRaw = execFileSync(
    'npx',
    ['--no-install', 'openapi-changes', 'report', '--no-color', oldPath, newPath],
    { encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'] }
  ).trim();
} catch (e) {
  const stderr = (e?.stderr || '').toString();
  const stdout = (e?.stdout || '').toString();
  fail(`Failed to run openapi-changes report.\n${stderr || stdout || e.message}`);
}

let report;
try {
  report = JSON.parse(reportRaw);
} catch {
  fail(`Unexpected openapi-changes output (not JSON):\n${reportRaw.slice(0, 500)}`);
}

const { totalChanges, breakingChanges } = sumChanges(report.reportSummary);

let recommendedBump = 'none';
if (breakingChanges > 0) {
  recommendedBump = 'major';
} else if (totalChanges > 0) {
  recommendedBump = 'minor';
} else if (args.noChange === 'patch') {
  recommendedBump = 'patch';
}

const versionsDoc = JSON.parse(fs.readFileSync(versionsPath, 'utf8'));
const currentContractVersion = versionsDoc.contractVersion;
if (!isSemver(currentContractVersion)) {
  fail(`Invalid contractVersion in ${versionsPath}: ${currentContractVersion}`);
}

const moduleEntries = Object.entries(versionsDoc.modules || {});
if (moduleEntries.length === 0) {
  fail(`No modules found in versions file: ${versionsPath}`);
}

for (const [moduleName, version] of moduleEntries) {
  if (!isSemver(version)) {
    fail(`Invalid module version for '${moduleName}' in ${versionsPath}: ${version}`);
  }
}

const nextContractVersion = bumpSemver(currentContractVersion, recommendedBump);
const nextModules = Object.fromEntries(
  moduleEntries.map(([name, version]) => [name, bumpSemver(version, recommendedBump)])
);

const result = {
  oldSpec: oldPath,
  newSpec: newPath,
  totals: {
    totalChanges,
    breakingChanges,
  },
  recommendedBump,
  versions: {
    current: {
      contractVersion: currentContractVersion,
      modules: versionsDoc.modules,
    },
    next: {
      contractVersion: nextContractVersion,
      modules: nextModules,
    },
  },
  written: false,
  versionsFile: versionsPath,
};

if (args.write) {
  versionsDoc.contractVersion = nextContractVersion;
  versionsDoc.modules = nextModules;
  versionsDoc.lastBump = {
    recommendedBump,
    totalChanges,
    breakingChanges,
    oldSpec: oldPath,
    newSpec: newPath,
    at: new Date().toISOString(),
  };
  fs.writeFileSync(versionsPath, `${JSON.stringify(versionsDoc, null, 2)}\n`);
  result.written = true;
}

console.log(JSON.stringify(result, null, 2));
