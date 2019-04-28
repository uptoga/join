#Create empty arrays
$DatasetA = @()
$DatasetB = @()
#Initialize "status" arrays to pull random values from
$ProductionStatusArray = @('In Production','Retired')
$PowerStatusArray = @('Online','Offline')
#Loop 1000 times to populate our separate datasets
1..100 | Foreach-Object {
    #Create one object with the current iteration attached to the name property
    #and a random power status
    $PropA = @{
        Name = "Server$_"
        PowerStatus = $PowerStatusArray[(Get-Random -Minimum 0 -Maximum 2)]
    }
    $DatasetA += New-Object -Type PSObject -Property $PropA
    #Create a second object with the same name and a random production status
    $PropB = @{
        Name = "Server$_"
        ProductionStatus = $ProductionStatusArray[(Get-Random -Minimum 0 -Maximum 2)]
    }
    $DatasetB += New-Object -Type PSObject -Property $PropB
}

$LinqJoinedData = [System.Linq.Enumerable]::Join(
    $DatasetA, 
    $DatasetB, 
    [System.Func[Object,string]] {param ($x);$x.Name},
    [System.Func[Object,string]]{param ($y);$y.Name},
    [System.Func[Object,Object,Object]]{
        param ($x,$y); 
        New-Object -TypeName PSObject -Property @{
        Name = $x.Name; 
        PowerStatus = $x.PowerStatus; 
        ProductionStatus = $y.ProductionStatus}
    }
)
$OutputArray = [System.Linq.Enumerable]::ToArray($LinqJoinedData)