export const parallelLetterFrequency = async (texts) => {
    const cnt = {};
    for (const text of texts)
        for (const c of text.toLowerCase().replace(/[-:'"()\s\d!,.;?]+/g, ""))
            cnt[c] = (cnt[c] || 0) + 1;
    return cnt;
};