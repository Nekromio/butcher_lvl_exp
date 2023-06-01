#pragma semicolon 1
#pragma newdecls required

#include <butcher_core>
#include <lvl_ranks>

ConVar
	cvLvlExpKill;

public Plugin myinfo =
{
	name = "[Butcher Core] LvL Rank exp",
	author = "Nek.'a 2x2 | ggwp.site ",
	description = "Дополнительный опыт Мяснику",
	version = "1.0.0",
	url = "https://ggwp.site/"
};

public void OnPluginStart()
{
	cvLvlExpKill = CreateConVar("sm_butcher_lvl_exp", "1.2", "Какой % бонусного опыта будет прибавлен Мяснику за убийство?");

	AutoExecConfig(true, "lvl_exp", "butcher");
}

public void LR_OnCoreIsReady()
{
	LR_Hook(LR_OnPlayerKilledPre, OnPlayerKilledPre);
}

void OnPlayerKilledPre(Event hEvent, int &iExpCaused, int iExpVictim, int iExpAttacker)
{
	int client = GetClientOfUserId(GetEventInt(hEvent, "attacker"));
	if(IsValidClient(client) && !IsFakeClient(client) && BUTCHER_GetStstusButcher(client))
		iExpCaused = RoundToNearest(iExpCaused * cvLvlExpKill.FloatValue);
}

stock bool IsValidClient(int client)
{
	return 0 < client <= MaxClients && IsClientInGame(client);
}