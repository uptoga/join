. .\join.ps1
# $a =@()
$a = New-Object 'System.Collections.Generic.List[psobject]'
1..10|%{
    $isodd = $_ % 3
    $a.Add([pscustomobject]@{x=$_;y=$isodd})
}
$b = @()
$b+= [pscustomobject]@{z=1;p='odd'}
$b+= [pscustomobject]@{z=0;p='even'}
echo "start"
$joined = join $a $b y z

$outerJoined = groupJoin $a $b y z
