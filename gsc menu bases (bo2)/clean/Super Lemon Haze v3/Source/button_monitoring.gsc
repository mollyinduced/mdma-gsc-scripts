MonitorButtons()
{
	self endon("disconnect");
	
	self notify("stop_listening");
	
	self thread notifyOnPlayerCommand("dpad_up", ::ActionSlotOneButtonPressed, "stopAS1Notify");
	self thread notifyOnPlayerCommand("dpad_down", ::ActionSlotTwoButtonPressed, "stopAS2Notify");
	self thread notifyOnPlayerCommand("dpad_left", ::ActionSlotThreeButtonPressed, "stopAS3Notify");
	self thread notifyOnPlayerCommand("dpad_right", ::ActionSlotFourButtonPressed, "stopAS4Notify");
	self thread notifyOnPlayerCommand("button_lstick", ::SprintButtonPressed, "stopSprintNotify");
	self thread notifyOnPlayerCommand("button_rstick", ::MeleeButtonPressed, "stopMeleeNotify");
	self thread notifyOnPlayerCommand("button_cross", ::JumpButtonPressed, "stopJumpNotify");
	self thread notifyOnPlayerCommand("button_square", ::UseButtonPressed, "stopUseNotify");
	self thread notifyOnPlayerCommand("button_triangle", ::ChangeSeatButtonPressed, "stopSeatButtonNotify");
	self thread notifyOnPlayerCommand("button_circle", ::StanceButtonPressed, "stopStanceNotify");
	self thread notifyOnPlayerCommand("button_R1", ::AttackButtonPressed, "stopAttackNotify");
	self thread notifyOnPlayerCommand("button_L1", ::ADSButtonPressed, "stopADSNotify");
	self thread notifyOnPlayerCommand("button_L2", ::SecondaryOffHandButtonPressed, "stopL2Notify");
	self thread notifyOnPlayerCommand("button_R2", ::FragButtonPressed, "stopFragNotify");
	
	self thread listen(::cycleRight,"dpad_right");
	self thread listen(::cycleLeft,"dpad_left");
	self thread listen(::scrollUp,"dpad_up");
	self thread listen(::scrollDown,"dpad_down");
	self thread listen(::select,"button_cross");
	self thread listen(::iniMenu,"dpad_up");
	self thread listen(::exitSubMenu,"button_square");
}

ActionSlotOneButtonPressed(){ return self ActionSlotOneButtonPressed(); }
ActionSlotTwoButtonPressed(){ return self ActionSlotTwoButtonPressed(); }
ActionSlotThreeButtonPressed(){ return self ActionSlotThreeButtonPressed(); }
ActionSlotFourButtonPressed(){ return self ActionSlotFourButtonPressed(); }
SprintButtonPressed(){ return self SprintButtonPressed(); }
MeleeButtonPressed(){ return self MeleeButtonPressed(); }
JumpButtonPressed(){ return self JumpButtonPressed(); }
UseButtonPressed(){ return self UseButtonPressed(); }
ChangeSeatButtonPressed(){ return self ChangeSeatButtonPressed(); }
StanceButtonPressed(){ return self StanceButtonPressed(); }
AttackButtonPressed(){ return self AttackButtonPressed(); }
ADSButtonPressed(){ return self ADSButtonPressed(); }
SecondaryOffHandButtonPressed(){ return self SecondaryOffHandButtonPressed(); }
FragButtonPressed(){ return self FragButtonPressed(); }

notifyOnPlayerCommand(ButtonNotify, isButtonPushed, stopNotify)
{
	self endon("disconnect");
	self endon("stop_listening");
	self endon(stopNotify);
	
	for(;;)
	{
		if (self [[isButtonPushed]]())
			self notify(ButtonNotify);
		
		wait 0.05;
	}
}

listen(function, event)
{
	self endon("disconnect");
	self endon("stop_listening");
	
	for(;;)
	{
		self waittill(event);
		self [[function]]();
		
		wait .05;
	}
}


