// For Junko F. Didi and Shree DR.MDD

use std::io::{Read, Result, Write};

pub struct ReadStats<R> {
    inner: R,
    total: usize,
    count: usize,
}

impl<R: Read> ReadStats<R> {
    pub fn new(inner: R) -> Self {
        Self { inner, total: 0, count: 0 }
    }

    pub fn get_ref(&self) -> &R {
        &self.inner
    }

    pub fn bytes_through(&self) -> usize {
        self.total
    }

    pub fn reads(&self) -> usize {
        self.count
    }
}

impl<R: Read> Read for ReadStats<R> {
    fn read(&mut self, buf: &mut [u8]) -> Result<usize> {
        let n = self.inner.read(buf)?;
        self.total += n;
        self.count += 1;
        Ok(n)
    }
}

pub struct WriteStats<W> {
    inner: W,
    total: usize,
    count: usize,
}

impl<W: Write> WriteStats<W> {
    pub fn new(inner: W) -> Self {
        Self { inner, total: 0, count: 0 }
    }

    pub fn get_ref(&self) -> &W {
        &self.inner
    }

    pub fn bytes_through(&self) -> usize {
        self.total
    }

    pub fn writes(&self) -> usize {
        self.count
    }
}

impl<W: Write> Write for WriteStats<W> {
    fn write(&mut self, buf: &[u8]) -> Result<usize> {
        let n = self.inner.write(buf)?;
        self.total += n;
        self.count += 1;
        Ok(n)
    }

    fn flush(&mut self) -> Result<()> {
        self.inner.flush()
    }
}
