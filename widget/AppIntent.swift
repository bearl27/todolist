//
//  AppIntent.swift
//  widget
//
//  Created by kai on 2024/06/18.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite(´ . .̫ . `)", default: "😃")
    var favoriteEmoji: String
}
