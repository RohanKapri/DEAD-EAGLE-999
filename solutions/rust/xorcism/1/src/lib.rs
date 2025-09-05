use std::io::{Read, Write};
use std::iter::Cycle;
pub trait Captures<'a> {}
impl<'a, T: ?Sized> Captures<'a> for T {}
#[derive(Clone)]
pub struct Xorcism<'a> {
    key: Cycle<std::slice::Iter<'a, u8>>,
}
impl<'a> Xorcism<'a> {
    pub fn new<Key: ?Sized + AsRef<[u8]>>(key: &'a Key) -> Xorcism<'a> {
        Self {
            key: key.as_ref().iter().cycle(),
        }
    }
    pub fn munge_in_place(&mut self, data: &mut [u8]) {
        for (a, b) in data.iter_mut().zip(self.key.by_ref()) {
            *a ^= *b;
        }
    }
    pub fn munge<'b, Data, D>(
        &'b mut self,
        data: Data,
    ) -> impl Iterator<Item = u8> + 'b + Captures<'a>
    where
        'a: 'b,
        Data: IntoIterator<Item = D> + 'b,
        D: std::ops::BitXor<u8, Output = u8>,
    {
        data.into_iter().zip(self.key.by_ref()).map(|(a, b)| a ^ *b)
    }
    pub fn reader<R: Read>(self, reader: R) -> Reader<'a, R> {
        Reader {
            stream_cipher: self,
            reader,
        }
    }
    pub fn writer<W: Write>(self, writer: W) -> Writer<'a, W> {
        Writer {
            stream_cipher: self,
            writer,
        }
    }
}
pub struct Reader<'a, R> {
    stream_cipher: Xorcism<'a>,
    reader: R,
}
impl<'a, R: Read> Read for Reader<'a, R> {
    fn read(&mut self, buf: &mut [u8]) -> std::io::Result<usize> {
        let bytes_read = self.reader.read(buf)?;
        self.stream_cipher.munge_in_place(&mut buf[0..bytes_read]);
        Ok(bytes_read)
    }
}
pub struct Writer<'a, W> {
    stream_cipher: Xorcism<'a>,
    writer: W,
}
impl<'a, W: Write> Write for Writer<'a, W> {
    fn write(&mut self, buf: &[u8]) -> std::io::Result<usize> {
        let b: Vec<u8> = self.stream_cipher.munge(buf).collect();
        self.writer.write(&b)
    }
    fn flush(&mut self) -> std::io::Result<()> {
        self.writer.flush()
    }
}