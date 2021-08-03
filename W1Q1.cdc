pub struct Canvas {
  pub let width: UInt8
  pub let height: UInt8
  pub let pixels: String

  init(width: UInt8, height: UInt8, pixels: String) {
    self.width = width
    self.height = height
    self.pixels = pixels
  }
}

pub resource Picture {
  pub let canvas: Canvas

  init(canvas: Canvas) {
    self.canvas = canvas
  }
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }
  return buffer 
}

pub fun main () {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]

  let canvasX = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixelsX)
  )

  let letterX <- create Picture(canvas: canvasX)
  log(display(canvas: letterX.canvas))
  destroy letterX
}

// Print the canvas to console using a pretty frame
pub fun display(canvas: Canvas) {
  log("+-----+")

  var i = 0
  let rowSpan = 5
  while i < canvas.pixels.length {
    log("|".concat(canvas.pixels.slice(from: i, upTo: i + rowSpan).concat( "|")))
    i = i + rowSpan
  }
    log("+-----+")
}

