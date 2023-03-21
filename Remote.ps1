$device = "172.23.128.201"
if ( $device | ? { $_ -match "[0-9].[0-9].[0-9].[0-9]" } )
{
    echo "Searching MAC by IP"
    $ip = $device
} 
else 
{
    echo "Searching MAC by host"
    $ip = [System.Net.Dns]::GetHostByName($device).AddressList[0].IpAddressToString
}
    $ping = ( new-object System.Net.NetworkInformation.Ping ).Send($ip);


if($ping){
    $mac = arp -a $ip;

    ( $mac | ? { $_ -match $ip } ) -match "([0-9A-F]{2}([:-][0-9A-F]{2}){5})" | out-null;

    if ( $matches )
     {
        $matches[0];
    } else 
    {
      echo "MAC Not Found"
     }
}