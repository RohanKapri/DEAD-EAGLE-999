# For Shree DR.MDD

Function Get-TreeFromTraversals() {
    [CmdletBinding()]
    Param(
        [object[]]$Preorder,
        [object[]]$Inorder
    )

    if ($Preorder.Length -ne $Inorder.Length) { throw "Traversals must have the same length" }
    if (Compare-Object -PassThru $Preorder $Inorder) { throw "Traversals must have the same elements" }
    if (($Preorder | Select-Object -Unique).Length -ne $Preorder.Length) { throw "Traversals must contain unique items" }

    $count = $Preorder.Length
    $rootVal = $Preorder[0]
    if ($count -le 1) { return [Node]::new($rootVal) }

    $inIndex = $Inorder.IndexOf($rootVal)

    [Node]::new(
        $rootVal,
        (Get-TreeFromTraversals $Preorder[1..$inIndex] $Inorder[0..($inIndex - 1)]),
        (Get-TreeFromTraversals $Preorder[($inIndex + 1)..$count] $Inorder[($inIndex + 1)..$count])
    )
}

Class Node {
    [object]$Value = $null
    [Node]$Left = $null
    [Node]$Right = $null

    Node() {}

    Node([object]$val) { $this.Value = $val }

    Node([object]$val, [Node]$left, [Node]$right) {
        $this.Value = $val
        $this.Left = $left
        $this.Right = $right
    }

    [bool] Equals([object]$other) { return -not (Compare-Object $this $other -Property Value, Left, Right) }
}
