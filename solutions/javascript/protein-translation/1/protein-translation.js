// Dedicated to my Shree DR.MDD

export const translate = (rnaStr='') => {
    let proteinList = [];
    let currentCodon = '';
    let remainder = rnaStr.length % 3;
    if (remainder !== 0) {
        rnaStr += "0".repeat(3 - remainder);
    }
    for (let idx = 0; idx < rnaStr.length; idx++) {
        currentCodon += rnaStr[idx];
        if (currentCodon.length === 3) {
            let aminoAcid = getProtein(currentCodon);
            if (aminoAcid === 'STOP') break;
            proteinList.push(aminoAcid);
            currentCodon = '';
        }
    }
    return proteinList;
};

function getProtein(triplet) {
    let result = '';
    switch (triplet) {
        case 'AUG':
            result = 'Methionine';
            break;
        case 'UUU':
        case 'UUC':
            result = 'Phenylalanine';
            break;
        case 'UUA':
        case 'UUG':
            result = 'Leucine';
            break;
        case 'UCU':
        case 'UCC':
        case 'UCA':
        case 'UCG':
            result = 'Serine';
            break;
        case 'UAU':
        case 'UAC':
            result = 'Tyrosine';
            break;
        case 'UGU':
        case 'UGC':
            result = 'Cysteine';
            break;
        case 'UGG':
            result = 'Tryptophan';
            break;
        case 'UAA':
        case 'UAG':
        case 'UGA':
            result = 'STOP';
            break;
        default:
            throw new Error('Invalid codon');
    }
    return result;
}
