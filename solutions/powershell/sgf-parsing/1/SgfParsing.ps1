
Class SgfTree {

    [hashtable] $Properties
    [SgfTree[]]  $Children

    SgfTree() {
        $this.Properties = @{}
        $this.Children   = @()
    }

    SgfTree($properties, $children) {
        $this.Properties = $properties
        $this.Children   = $children
    }

    [bool] Equals($other) {
        if ($other -eq $null) {
            return $false;
        }
        $matchesKeys = -not (Compare-Object $this.Properties.Keys $other.Properties.Keys);
        $matchesValues = -not (Compare-Object $this.Properties.Values $other.Properties.Values);
        if ($matchesKeys -and $matchesValues) {
            if ($this.Children.Count -ne $other.Children.Count) {
                return $false;
            }
            for ($i = 0; $i -lt $this.Count; $i++) {
                if (($this.Children[$i] -eq $null -and ($this.Children[$i] -ne $null)) -or
                    ($this.Children[$i] -ne $null -and ($this.Children[$i] -eq $null))) {
                    return $false;
                }
                if (($this.Children[$i] -ne $null -and ($this.Children[$i] -ne $null)) -and
                    $this.Children[$i].Equals($other.Children[$i]) -eq $false) {
                    return $false;
                }
            }
            return $true;
        }
        return $false;
    }
}

$intitable = @(0,0,0,0,0,0,0,0,0);

function getnextitems([int]$i,[string]$Data,[int]$inti) {
    $properties = @{};
    $children = @();
    while ($i -lt $Data.Length -and $Data[$i] -ne ';' -and $Data[$i] -ne '(' -and $Data[$i] -ne ')') {
        $j = $i;
        while ($j -lt $Data.Length -and $Data[$j] -ge 65 -and $Data[$j] -le 90) {
           $j++;
        }
        if ($Data[$j] -eq ')') {
           if ($j-$i -eq 0) {
              return $obj;
           }
           throw "*Properties without delimiter*";
        }
        $s = $Data.substring($i,$j-$i);
        if ($i -eq $j -or $s -cmatch "[a-z]+") {
            throw "*Property must be in uppercase*";
        }
        $i = $j;
        $items = @();
        while (1) {#$i -lt $Data.Length -and $Data[$i] -ne '(' -and $Data[$i] -ne ';') {
           if ($Data[$i] -eq '[') {
              $i++;
              $j = $i;

              $s2 = $Data.substring($i);
              $s3 = "";
              $k = 0;
              while ($k -lt $s2.Length -and $s2[$k] -ne ']') {
                 if ($s2[$k] -eq '\' -and ($k+1) -lt $s2.Length -and $s2[$k+1] -eq '\') {
                    $k += 2;
                    if ($s2[$k] -eq '\' -and $s2[$k+1] -eq '\') {
                      $s3 += '\';
                      $s3 += '\'; 
                      $k += 2;
                    } elseif ($s2[$k] -eq ']') {
                      $s3 += ']';
                      $k++;
                    } elseif ($s2[$k] -eq '\' -and $s2[$k+1] -eq 'n') {
                      $k += 2;
                    }
                 } else {
                   $s3 += $s2[$k];
                   $k++;
                 }
              }
              $s3 = $s3.Replace("\t"," ");
              $items += $s3;
              $i += $k;
           } else {
              break;
           }
           $i++;
        }
        $properties[$s] = $items;
    }   
    while ($i -lt $Data.Length -and ($Data[$i] -eq '(' -or $Data[$i] -eq ';')) {
        while ($i -lt $Data.Length -and $Data[$i] -ne ';') {
            $i++;
        }
        $i++;
        $children += (getnextitems $i $Data ($inti+1));
        $i = $intitable[$inti+1];
        if ($Data[$i] -eq ')')  {
            $i++;
        }
    }
    $intitable[$inti] = $i;
    return [SgfTree]::new($properties,$children);
}

function Invoke-Parser {
    param (
        [string]$Data
    )
    if ($Data.Length -eq 0 -or $Data[0] -eq ";") {
        throw "*Tree missing*";
    }
    if ($Data -eq "()") {
        throw "*Tree with no nodes*";
    }
    $i = 2;
    $obj = getnextitems 2 $Data 0;
    return $obj;
}