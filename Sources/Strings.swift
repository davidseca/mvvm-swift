// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum About {
    /// MVPSwift App developed by David Seca
    internal static let content = L10n.tr("Localizable", "About.content")
  }

  internal enum Accounts {
    internal enum Cell {
      /// Number: %@ Balance: %@
      internal static func info(_ p1: String, _ p2: String) -> String {
        return L10n.tr("Localizable", "Accounts.Cell.info", p1, p2)
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
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
