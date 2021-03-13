//
//  Crawl.swift
//  MiniProjectCrawl
//
//  Created by Takayasu Nasu on 2021/03/11.
//

import Foundation

// following command to test and build original command.
// cat  Crawl.swift main.swift  | swift -
// swiftc main.swift Crawl.swift -o xTree

enum Symbol: String {
  case blank = "   "
  case vertical = "│  "
  case content = "├─ "
  case end = "└─ "
}

struct Creawl {
  
  let fileManager = FileManager()

  private func xTreeHelper(_ path: String, _ indent: Int) {
    var files: [String] = []
    if let pathList = try? self.fileManager.contentsOfDirectory(atPath: path) {
      let newIndent = indent + 1
      for fileOrDirectory in pathList {
        if self.isDirectory("\(path)/\(fileOrDirectory)") {
          print("\(self.depth(newIndent))\(Symbol.content.rawValue)\(fileOrDirectory)")
          xTreeHelper("\(path)/\(fileOrDirectory)", newIndent)
        } else {
          files.append(fileOrDirectory)
        }
      }
      self.printFiles(files, newIndent)
    }
  }

  private func isDirectory(_ path: String) -> Bool {
    var isDir: ObjCBool = false
    self.fileManager.fileExists(atPath: "\(path)", isDirectory: &isDir)
    return isDir.boolValue
  }

  private func printFiles(_ files: [String], _ indent: Int) {
    let vertical = self.depth(indent)
    for (i, file) in files.enumerated() {
      if i == files.count - 1 {
        print("\(vertical)\(Symbol.end.rawValue)\(file)")
      } else {
        print("\(vertical)\(Symbol.content.rawValue)\(file)")
      }
    }
  }

  private func depth(_ indent: Int) -> String {
    var vertical = ""
    for _ in 0..<indent {
      vertical += Symbol.vertical.rawValue
      vertical += Symbol.blank.rawValue
    }
    return vertical
  }

  func xTree() {
    print(fileManager.currentDirectoryPath)
    let basePath = "."
    self.xTreeHelper(basePath, -1)
  }

}
