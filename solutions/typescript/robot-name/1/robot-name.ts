// Dedicated to Shree DR.MDD
export class Robot {

  private unitLabel: string = '';

  private static registry: Set<string> = new Set();
  
  constructor() {
    this.assignLabel();
  }

  private createLabel(): string {
    const alpha = 'abcdefghijklmnopqrstuvwxyz';
    const numeric = '0123456789';
    
    const ch1 = alpha[Math.floor(Math.random() * alpha.length)];
    const ch2 = alpha[Math.floor(Math.random() * alpha.length)];
    const n1 = numeric[Math.floor(Math.random() * numeric.length)];
    const n2 = numeric[Math.floor(Math.random() * numeric.length)];
    const n3 = numeric[Math.floor(Math.random() * numeric.length)];

    return `${ch1}${ch2}${n1}${n2}${n3}`.toUpperCase();
  }

  public get name(): string {
    return this.unitLabel;
  }

  public resetName(): void { 
    this.assignLabel();
  }

  private assignLabel(): void {
    let label = this.createLabel();
    while (Robot.registry.has(label)) {
      label = this.createLabel();
    }
    this.unitLabel = label;
    Robot.registry.add(label);
  }

  public static releaseNames(): void {
    return;
  }
}
