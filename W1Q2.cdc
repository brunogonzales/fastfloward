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

// Returns a picture only if it hasn't been already printed
pub resource Printer {
  pub let printedCanvas: {String: Canvas}
  init() {
    self.printedCanvas = {}
  }
  pub fun print(canvas: Canvas): @Picture? {
    if(self.printedCanvas.containsKey(canvas.pixels)) {
      return nil
    } else {
      let picture <- create Picture(canvas: canvas)
      self.printedCanvas[canvas.pixels] = canvas
      return <- picture
    }
  }
}