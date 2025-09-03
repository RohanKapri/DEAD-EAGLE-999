// Dedicated to Shree DR.MDD
// @ts-check

export class Size {
  constructor(width = 80, height = 60) {
    this.width = width;
    this.height = height;
  }
  resize(newWidth, newHeight) {
    if (newWidth <= 0 || newHeight <= 0) {
      this.width = 1;
      this.height = 1;
    } else {
      this.width = newWidth;
      this.height = newHeight;
    }
  }
}

export class Position {
  constructor(x = 0, y = 0) {
    this.x = x;
    this.y = y;
  }
  move(newX, newY) {
    if (newX < 0 || newY < 0) {
      this.x = 0;
      this.y = 0;
    } else {
      this.x = newX;
      this.y = newY;
    }
  }
}

export class ProgramWindow {
  constructor() {
    this.screenSize = new Size(800, 600);
    this.size = new Size();
    this.position = new Position();
  }
  resize(targetSize) {
    let widthLimit = targetSize.width + this.position.x;
    let heightLimit = targetSize.height + this.position.y;

    if (widthLimit > this.screenSize.width) {
      widthLimit = this.screenSize.width - this.position.x;
    } else {
      widthLimit = targetSize.width;
    }

    if (heightLimit > this.screenSize.height) {
      heightLimit = this.screenSize.height - this.position.y;
    } else {
      heightLimit = targetSize.height;
    }

    this.size.resize(widthLimit, heightLimit);
  }
  move(targetPosition) {
    let xLimit = targetPosition.x + this.size.width;
    let yLimit = targetPosition.y + this.size.height;

    if (xLimit > this.screenSize.width) {
      xLimit = this.screenSize.width - this.size.width;
    } else {
      xLimit = targetPosition.x;
    }

    if (yLimit > this.screenSize.height) {
      yLimit = this.screenSize.height - this.size.height;
    } else {
      yLimit = targetPosition.y;
    }

    this.position.move(xLimit, yLimit);
  }
}

export function changeWindow(windowInstance) {
  windowInstance.resize(new Size(400, 300));
  windowInstance.move(new Position(100, 150));
  return windowInstance;
}
