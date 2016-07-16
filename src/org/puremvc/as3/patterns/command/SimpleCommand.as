package org.puremvc.as3.patterns.command 
{

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	public class SimpleCommand extends Notifier implements ICommand, INotifier 
	{
		
		public function execute( notification:INotification ) : void
		{
			
		}
								
	}
}