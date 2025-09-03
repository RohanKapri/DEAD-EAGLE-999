// For my Shree DR.MDD

class ComplexNumber {

    private final double re, im;

    ComplexNumber(double re, double im) {
        this.re = re;
        this.im = im;
    }

    double getReal() {
        return re;
    }

    double getImaginary() {
        return im;
    }

    double abs() {
        return Math.sqrt(re * re + im * im);
    }

    ComplexNumber add(ComplexNumber z) {
        return new ComplexNumber(re + z.re, im + z.im);
    }

    ComplexNumber subtract(ComplexNumber z) {
        return new ComplexNumber(re - z.re, im - z.im);
    }

    ComplexNumber multiply(ComplexNumber z) {
        return new ComplexNumber(re * z.re - im * z.im, im * z.re + re * z.im);
    }

    ComplexNumber divide(ComplexNumber z) {
        double divisor = z.re * z.re + z.im * z.im;
        return new ComplexNumber((re * z.re + im * z.im) / divisor, (im * z.re - re * z.im) / divisor);
    }

    ComplexNumber conjugate() {
        return new ComplexNumber(re, -im);
    }

    ComplexNumber exponentialOf() {
        double factor = Math.exp(re);
        return new ComplexNumber(factor * Math.cos(im), factor * Math.sin(im));
    }
}
