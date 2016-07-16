package org.puremvc.as3.patterns.observer
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.patterns.facade.Facade;
	

	public class Notifier implements INotifier
	{

		public function sendNotification( notificationName:String, body:Object=null, type:String=null ):void 
		{
			facade.sendNotification( notificationName, body, type );
		}
		
		// Local reference to the Facade Singleton
		protected var facade:IFacade = Facade.getInstance();
	}
}