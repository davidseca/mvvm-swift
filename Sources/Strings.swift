// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum About {
    /// MVVMSwift App developed by David Seca
    internal static let content = L10n.tr("Localizable", "About.content")
  }

  internal enum Accounts {
    internal enum Cell {
      /// Number: %@ Balance: %@
      internal static func info(_ p1: Any, _ p2: Any) -> String {
        return L10n.tr("Localizable", "Accounts.Cell.info", String(describing: p1), String(describing: p2))
      }
    }
    internal enum ModeControl {
      /// All
      internal static let all = L10n.tr("Localizable", "Accounts.ModeControl.all")
      /// Visibles
      internal static let visibles = L10n.tr("Localizable", "Accounts.ModeControl.visibles")
    }
    internal enum Empty {
      /// No accounts
      internal static let title = L10n.tr("Localizable", "Accounts.empty.title")
    }
  }

  internal enum Tabbar {
    /// Info
    internal static let about = L10n.tr("Localizable", "Tabbar.about")
    /// Accounts
    internal static let accounts = L10n.tr("Localizable", "Tabbar.accounts")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
