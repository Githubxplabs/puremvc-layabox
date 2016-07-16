package org.puremvc.as3.patterns.command 
{

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	public class MacroCommand extends Notifier implements ICommand, INotifier
	{
		
		private var subCommands:Array;
		
		public function MacroCommand()
		{
			subCommands = new Array();
			initializeMacroCommand();			
		}
		
		protected function initializeMacroCommand():void
		{
		}
		
		protected function addSubCommand( commandClassRef:Class ): void
		{
			subCommands.push(commandClassRef);
		}
		
		public final function execute( notification:INotification ) : void
		{
			while ( subCommands.length > 0) {
				var commandClassRef : Class = subCommands.shift();
				var commandInstance : ICommand = new commandClassRef();
				commandInstance.execute( notification );
			}
		}
								
	}
}