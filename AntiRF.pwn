//Snippet: Anti reconnect flood by RogueDrifter 2017-12-21
#define AntiReconnecters "Reconnecters/%s.ini"// Create "Reconnecters" in your scriptfiles folder.
#define ReconnectTime 5 // Increase For More Sensitivity AND Decrease for Lower Sensitivity.
new ifile[256],pIPAddress[MAX_PLAYERS][32],iday[MAX_PLAYERS],iyear[MAX_PLAYERS],imonth[MAX_PLAYERS],ihour[MAX_PLAYERS],isec[MAX_PLAYERS],imin[MAX_PLAYERS];
//Put the above on top of the script ^^
public OnIncomingConnection(playerid, ip_address[], port) // Under OnIncomingConnection or anywhere if u don't use it.
{
    gettime(ihour[playerid],imin[playerid],isec[playerid]),getdate(iyear[playerid],imonth[playerid],iday[playerid]);
    format(ifile,sizeof(ifile),AntiReconnecters,ip_address);
    format(pIPAddress[playerid], 32, "%s", ip_address);
    new susec[MAX_PLAYERS];
    susec[playerid] = isec[playerid] - dini_Int(ifile,"SECOND");
    if(!dini_Exists(ifile))
    {
        dini_Create(ifile);
        dini_IntSet(ifile,"YEAR",iyear[playerid]),dini_IntSet(ifile,"MONTH",imonth[playerid]),dini_IntSet(ifile,"DAY",iday[playerid]);
        dini_IntSet(ifile,"HOUR",ihour[playerid]),dini_IntSet(ifile,"MINUTE",imin[playerid]),dini_IntSet(ifile,"SECOUND",isec[playerid]);
        }
    else
    {
        if(iyear[playerid] == dini_Int(ifile,"YEAR") && imonth[playerid] == dini_Int(ifile,"MONTH") && iday[playerid] == dini_Int(ifile,"DAY") && ihour[playerid] == dini_Int(ifile,"HOUR") && dini_Int(ifile,"MINUTE") == imin[playerid])
        {
            if(susec[playerid] > ReconnectTime )
            {
                BlockIpAddress(ip_address, 30 * 1000);
                Kick(playerid);
                }
            }
        }
    return 1;
}
public OnPlayerDisconnect(playerid,reason) // Under OnPlayerDisconnect put this.
{
    gettime(ihour[playerid],imin[playerid],isec[playerid]),getdate(iyear[playerid],imonth[playerid],iday[playerid]);
    format(ifile,sizeof(ifile),AntiReconnecters, pIPAddress[playerid]);
    dini_IntSet(ifile,"YEAR",iyear[playerid]),dini_IntSet(ifile,"MONTH",imonth[playerid]),dini_IntSet(ifile,"DAY",iday[playerid]);
    dini_IntSet(ifile,"HOUR",ihour[playerid]),dini_IntSet(ifile,"MINUTE",imin[playerid]),dini_IntSet(ifile,"SECOUND",isec[playerid]);
    return 1;
}
