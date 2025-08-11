pub const SearchError = error{
    ValueAbsent,
    EmptyBuffer,
};

pub fn binarySearch(comptime T: type, target: usize, buffer: ?[]const T) ?usize {
    const buff = buffer orelse return null;
    
    if (buff.len == 0) {
        return null;
    }
    
    var low: usize = 0;
    var high: usize = buff.len;
    
    while (low < high) {
        const mid = low + ((high - low) / 2);
        if (buff[mid] == target) {
            return mid;
        } else if (buff[mid] > target) {
            high = mid;
        } else {
            low = mid + 1;
        }
    }
    return null;
}