//
//  PaginatorV2.swift
//
//
//  Created by Nikita Abramenko on 10.03.2024.
//

import Foundation

public class Paging {
    public typealias Value = Int
    
    public var first: Int = 1
    public var current: Int = 1
    
    public init() {}
    
    public func next() -> Int {
        return self.current + 1
    }
    
    public func turnNext() {
        self.current = self.next()
    }
    
    public func reset() {
        self.current = self.first
    }
}

public enum PaginatorData<T> {
    case first([T])
    case next([T])
}

@MainActor
public final class Paginator<T> {
    private let requestFactory: (Paging.Value) async throws -> [T]
    private let paging: Paging = Paging()
    public let handler: Handler<T> = Handler()
    
    public init(requestFactory: @escaping (Paging.Value) async throws -> [T]) {
        self.requestFactory = requestFactory
    }
    
    private lazy var currentState: State = EmptyState(self)
    
    func restart() async {
        await self.currentState.restart()
    }
    
    public func refresh() async {
        await self.currentState.refresh()
    }
    
    public func loadNewPage() async {
        await self.currentState.loadNewPage()
    }
    
    func release() {
        self.currentState.release()
    }
    
    private func loadPage(_ page: Paging.Value) async {
        do {
            let result = try await self.requestFactory(page)
            self.currentState.newData(result)
        } catch {
            self.currentState.fail(error)
        }
    }
    
    private final class EmptyState: State<T> {
        override func restart() async {
            await self.refresh()
        }
        
        override func refresh() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func release() {
            guard let paginator else { return }
            paginator.currentState = ReleasedState(paginator)
        }
    }
    
    private final class EmptyProgressState: State<T> {
        override func restart() async {
            guard let paginator else { return }
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func newData(_ data: [T]) {
            guard let paginator else { return }
            if !data.isEmpty {
                paginator.currentState = DataState(paginator)
                paginator.paging.reset()
                paginator.handler.showData?((true, .first(data)))
                paginator.handler.showEmptyProgress?(false)
            } else {
                paginator.currentState = EmptyDataState(paginator)
                paginator.handler.showEmptyProgress?(false)
                paginator.handler.showEmptyView?(true)
            }
        }
        
        override func fail(_ error: Error) {
            guard let paginator else { return }
            paginator.currentState = EmptyErrorState(paginator)
            paginator.handler.showEmptyProgress?(false)
            paginator.handler.showEmptyError?((true, error))
        }
        
        override func release() {
            guard let paginator else { return }
            paginator.currentState = ReleasedState(paginator)
        }
    }
    
    private final class EmptyErrorState: State<T> {
        override func restart() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showEmptyError?((false, nil))
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func refresh() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showEmptyError?((false, nil))
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func release() {
            guard let paginator else { return }
            paginator.currentState = ReleasedState(paginator)
        }
    }
    
    private final class EmptyDataState: State<T> {
        override func restart() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showEmptyView?(false)
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func refresh() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showEmptyView?(false)
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func release() {
            guard let paginator else { return }
            paginator.currentState = ReleasedState(paginator)
        }
    }
    
    private final class DataState: State<T> {
        override func restart() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showData?((false, .first([])))
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func refresh() async {
            guard let paginator else { return }
            paginator.currentState = RefreshState(paginator)
            paginator.handler.showRefreshProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func loadNewPage() async {
            guard let paginator else { return }
            paginator.currentState = PageProgressState(paginator)
            paginator.handler.showPageProgress?(true)
            await paginator.loadPage(paginator.paging.next())
        }
        
        override func release() {
            guard let paginator else { return }
            paginator.currentState = ReleasedState(paginator)
        }
    }
    
    private final class RefreshState: State<T> {
        override func restart() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showData?((false, .first([])))
            paginator.handler.showRefreshProgress?(false)
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func newData(_ data: [T]) {
            guard let paginator else { return }
            if !data.isEmpty {
                paginator.currentState = DataState(paginator)
                paginator.paging.reset()
                paginator.handler.showRefreshProgress?(false)
                paginator.handler.showData?((true, .first(data)))
            } else {
                paginator.currentState = EmptyDataState(paginator)
                paginator.handler.showData?((false, .first([])))
                paginator.handler.showRefreshProgress?(false)
                paginator.handler.showEmptyView?(true)
            }
        }
        
        override func fail(_ error: Error) {
            guard let paginator else { return }
            paginator.currentState = DataState(paginator)
            paginator.handler.showRefreshProgress?(false)
            paginator.handler.showErrorMessage?(error)
        }
        
        override func release() {
            guard let paginator else { return }
            paginator.currentState = ReleasedState(paginator)
        }
    }
    
    private final class PageProgressState: State<T> {
        override func restart() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showData?((false, .first([])))
            paginator.handler.showPageProgress?(false)
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func newData(_ data: [T]) {
            guard let paginator else { return }
            if !data.isEmpty {
                paginator.currentState = DataState(paginator)
                paginator.paging.turnNext()
                paginator.handler.showPageProgress?(false)
                paginator.handler.showData?((true, .next(data)))
            } else {
                paginator.currentState = AllDataState(paginator)
                paginator.handler.showPageProgress?(false)
                paginator.handler.allDataFetched?()
            }
        }
        
        override func refresh() async {
            guard let paginator else { return }
            paginator.currentState = RefreshState(paginator)
            paginator.handler.showPageProgress?(false)
            paginator.handler.showRefreshProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func fail(_ error: Error) {
            guard let paginator else { return }
            paginator.currentState = DataState(paginator)
            paginator.handler.showPageProgress?(false)
            paginator.handler.showErrorMessage?(error)
        }
        
        override func release() {
            guard let paginator else { return }
            paginator.currentState = ReleasedState(paginator)
        }
    }
    
    private final class AllDataState: State<T> {
        override func restart() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showData?((false, .first([])))
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func refresh() async {
            guard let paginator else { return }
            paginator.currentState = RefreshState(paginator)
            paginator.handler.showRefreshProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func release() {
            guard let paginator else { return }
            paginator.currentState = ReleasedState(paginator)
        }
    }
    
    private final class ReleasedState: State<T> {
        override func restart() async {
            guard let paginator else { return }
            paginator.currentState = EmptyProgressState(paginator)
            paginator.handler.showData?((false, .first([])))
            paginator.handler.showEmptyView?(false)
            paginator.handler.showEmptyProgress?(true)
            await paginator.loadPage(paginator.paging.first)
        }
        
        override func refresh() async {
            await self.restart()
        }
    }
    
    @MainActor
    private class State<N> {
        weak var paginator: Paginator<N>?
        init(_ paginator: Paginator<N>) {
            self.paginator = paginator
        }
        
        func restart() async {}
        func refresh() async {}
        func loadNewPage() async {}
        func release() {}
        func newData(_ data: [N]) {}
        func fail(_ error: Error) {}
    }
    
    @MainActor
    public final class Handler<Q> {
        fileprivate var showEmptyProgress: PaginatorAction<Bool>?
        fileprivate var showEmptyError: PaginatorAction<(show: Bool, error: Error?)>?
        fileprivate var showEmptyView: PaginatorAction<Bool>?
        fileprivate var showData: PaginatorAction<(show: Bool, data: PaginatorData<Q>)>?
        fileprivate var showErrorMessage: PaginatorAction<Error>?
        fileprivate var showRefreshProgress: PaginatorAction<Bool>?
        fileprivate var showPageProgress: PaginatorAction<Bool>?
        fileprivate var allDataFetched: PaginatorActionFunc?
        
        @discardableResult
        func showEmptyProgress(_ action: @escaping PaginatorAction<Bool>) -> Handler<Q> {
            self.showEmptyProgress = action
            return self
        }
        
        @discardableResult
        func showEmptyError(_ action: @escaping PaginatorAction<(show: Bool, error: Error?)>) -> Handler<Q> {
            self.showEmptyError = action
            return self
        }
        
        @discardableResult
        public func showEmptyView(_ action: @escaping PaginatorAction<Bool>) -> Handler<Q> {
            self.showEmptyView = action
            return self
        }
        
        @discardableResult
        public func showData(_ action: @escaping PaginatorAction<(show: Bool, data: PaginatorData<Q>)>) -> Handler<Q> {
            self.showData = action
            return self
        }
        
        @discardableResult
        public func showErrorMessage(_ action: @escaping PaginatorAction<Error>) -> Handler<Q> {
            self.showErrorMessage = action
            return self
        }
        
        @discardableResult
        func showRefreshProgress(_ action: @escaping PaginatorAction<Bool>) -> Handler<Q> {
            self.showRefreshProgress = action
            return self
        }
        
        @discardableResult
        func showPageProgress(_ action: @escaping PaginatorAction<Bool>) -> Handler<Q> {
            self.showPageProgress = action
            return self
        }
        
        @discardableResult
        func allDataFetched(_ action: @escaping PaginatorActionFunc) -> Handler<Q> {
            self.allDataFetched = action
            return self
        }
    }
}

public typealias PaginatorActionFunc = () -> Void
public typealias PaginatorAction<T> = (T) -> Void
