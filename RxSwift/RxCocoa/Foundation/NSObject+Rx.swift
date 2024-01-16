//
//  NSObject+Rx.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 2/21/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if !os(Linux)

import Foundation

private var deallocatedSubjectTriggerContext: UInt8 = 0
private var deallocatedSubjectContext: UInt8 = 0


// Dealloc
extension Reactive where Base: AnyObject {
    
    /**
    Observable sequence of object deallocated events.
    
    After object is deallocated one `()` element will be produced and sequence will immediately complete.
    
    - returns: Observable sequence of object deallocated events.
    */
    public var deallocated: Observable<Void> {
        return self.synchronized {
            if let deallocObservable = objc_getAssociatedObject(self.base, &deallocatedSubjectContext) as? DeallocObservable {
                return deallocObservable.subject
            }

            let deallocObservable = DeallocObservable()

            objc_setAssociatedObject(self.base, &deallocatedSubjectContext, deallocObservable, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return deallocObservable.subject
        }
    }
}

private final class DeallocObservable {
    let subject = ReplaySubject<Void>.create(bufferSize:1)

    init() {
    }

    deinit {
        self.subject.on(.next(()))
        self.subject.on(.completed)
    }
}

// MARK: Constants

private let deallocSelector = NSSelectorFromString("dealloc")

// MARK: AnyObject + Reactive

extension Reactive where Base: AnyObject {
    func synchronized<T>( _ action: () -> T) -> T {
        objc_sync_enter(self.base)
        let result = action()
        objc_sync_exit(self.base)
        return result
    }
}

extension Reactive where Base: AnyObject {
    /**
     Helper to make sure that `Observable` returned from `createCachedObservable` is only created once.
     This is important because there is only one `target` and `action` properties on `NSControl` or `UIBarButtonItem`.
     */
    func lazyInstanceObservable<T: AnyObject>(_ key: UnsafeRawPointer, createCachedObservable: () -> T) -> T {
        if let value = objc_getAssociatedObject(self.base, key) {
            return value as! T
        }
        
        let observable = createCachedObservable()
        
        objc_setAssociatedObject(self.base, key, observable, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        return observable
    }
}

#endif
