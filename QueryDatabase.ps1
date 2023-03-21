param(
    [Parameter(Mandatory=$true)][GUID]$poId,
    [Parameter(Mandatory=$true)][GUID] $masterDataId
)

function Execute()
{
$SQLServer = "."
$db3 = "Plant"
$AttachmentPath = "D:\pos.csv"
$selectdata = [string]::Format("Select Count(Id) AS 'Total POs' from PO with (nolock)
Select Count(Id) AS 'Total Items' From Item with (nolock)
Select Count(Id) AS 'Total ItemUSCs' From ItemUSC with (nolock)
Select Count(Id) AS 'Total USCs' From USC with (nolock)
Select Count(Id) AS 'Total CPUs' From CodePoolUSC with (nolock)
Select Count(Id) AS 'Total POMasterData' from POMasterData with (nolock)

declare @poIds table(Id uniqueidentifier)
insert into @poIds select distinct p.Id from Po p Join POReportHistory porh with(nolock) on p.Id = porh.PoID
Where (p.Status = 130) AND
--POs with Exported status
porh.Timestamp = (Select MAX(Timestamp) From POReportHistory with(nolock) Where (Status = 130 ) and PoID = porh.PoID)
and DATEDIFF(Day, Convert(varchar(10), porh.TimeStamp, 111), Convert(varchar(10), GetDate(), 111)) > 7 

Select Count(Id) AS 'POs To Delete' from @poIds 
SELECT LotNumber,Number FROM PO where Id IN (SELECT ID FROM @poIds)
Select Count(i.Id) AS 'Items To Delete' From Item i  with (nolock) JOIN @poIds pid ON i.Po = pid.Id
Select Count(iu.Id) AS 'ItemUSCs To Delete' From ItemUSC iu with (nolock) JOIN USC u ON iu.USC = u.Id JOIN @poIds pid ON u.POID = pid.Id JOIN Item i with (nolock) ON iu.Item = i.Id
Select Count(u.Id) AS 'USCs To Delete' From USC u with (nolock) JOIN @poIds pid ON u.POID = pid.Id
Select Count(cpu.Id) AS 'CPUs To Delete' From CodePoolUSC cpu with (nolock) JOIN USC u ON cpu.SerialNumber = u.Number JOIN @poIds pid ON u.POID = pid.Id", $poId, $masterDataId)
 #exec spPO_SN_List @poNumber = {0}, @lotNumber = '{1}', @excludeDeletedPOs = {2}
Invoke-Sqlcmd -ServerInstance $SQLServer -Database $db3 -Query $selectdata | Export-CSV $AttachmentPath
}

Execute