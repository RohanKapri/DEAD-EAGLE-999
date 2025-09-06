sub flatten-array (@nested) is export {
    grep(*.defined, gather @nested>>.take).Array
}