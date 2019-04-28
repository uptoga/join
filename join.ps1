function join {
    param(
        $left,
        $right,
        $lon,
        $requal
    )
    $lnqData = [System.Linq.Enumerable]::Join(
        $left,
        $right,
        [System.Func[System.Object, string]] { param($x); $x.($lon) },
        [System.Func[System.Object, string]] { param($y); $y.($requal) },
        [System.Func[System.Object, System.Object, System.Object]] {
            param($x, $y);
            
            # $xf = $x | gm | ? { $_.MemberType -eq 'NoteProperty' } | % name
            $xf = $x[0].psobject.Properties.name
            # $yf = $y | gm | ? { $_.MemberType -eq 'NoteProperty' } | % name
            $yf = $y[0].psobject.Properties.name
            $ht = @{ }
            foreach ($f in $xf) { $ht.Add($f, $x.($f)) }
            foreach ($f in $yf) { try { $ht.Add($f, $y.($f)) }catch { } }
            New-Object -TypeName psobject -Property $ht
        }
    )
    $lnqData
}

function groupJoin {
    param(
        $left,
        $right,
        $lon,
        $requal
    )
    $lnqData = [System.Linq.Enumerable]::GroupJoin(
        $left,
        $right,
        [System.Func[System.Object, string]] { param($x); $x.($lon) },
        [System.Func[System.Object, string]] { param($y); $y.($requal) },
        [System.Func[System.Object, [Collections.Generic.Ienumerable[System.Object]], System.Object]] {
            param($x, $yenum);
            $y = [System.Linq.Enumerable]::SingleOrDefault($yenum)
            # $xf = $x | gm | ? { $_.MemberType -eq 'NoteProperty' } | % name
            $xf = $x[0].psobject.Properties.name
            # $yf = $y | gm | ? { $_.MemberType -eq 'NoteProperty' } | % name
            $yf = $y.psobject.Properties.name
            $ht = @{ }
            foreach ($f in $xf) { $ht.Add($f, $x.($f)) }
            foreach ($f in $yf) { try { $ht.Add($f, $y.($f)) }catch { } }
            New-Object -TypeName psobject -Property $ht
        }
    )
    $lnqData
}