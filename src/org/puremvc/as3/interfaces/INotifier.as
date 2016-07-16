package org.puremvc.as3.interfaces
{

	public interface INotifier
	{

		function sendNotification( notificationName:String, body:Object=null, type:String=null ):void; 
		
	}
}