//
//  UIDatePicker+Rx.swift
//  RxCocoa
//
//  Created by Daniel Tartaglia on 5/31/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS)

import RxSwift
import UIKit

extension Reactive where Base: UIDatePicker {
    /// Reactive wrapper for `date` property.
    public var date: ControlProperty<Date> {
        return value
    }

    /// Reactive wrapper for `date` property.
    public var value: ControlProperty<Date> {
        return base.rx.controlPropertyWithDefaultEvents(
            getter: { datePick in
                datePick.date
            }, setter: { datePick, value in
                datePick.date = value
            }
        )
    }

    /// Reactive wrapper for `countDownDuration` property.
    public var countDownDuration: ControlProperty<TimeInterval> {
        return base.rx.controlPropertyWithDefaultEvents(
            getter: { datePick in
                datePick.countDownDuration
            }, setter: { datePick, value in
                datePick.countDownDuration = value
            }
        )
    }
}

#endif
