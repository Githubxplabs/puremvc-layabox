package org.puremvc.as3.patterns.observer
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IObserver;


	public class Observer implements IObserver
	{
		private var notify:Function;
		private var context:Object;
	

		public function Observer( notifyMethod:Function, notifyContext:Object ) 
		{
			setNotifyMethod( notifyMethod );
			setNotifyContext( notifyContext );
		}
		

		public function setNotifyMethod( notifyMethod:Function ):void
		{
			notify = notifyMethod;
		}
		

		public function setNotifyContext( notifyContext:Object ):void
		{
			context = notifyContext;
		}
		

		private function getNotifyMethod():Function
		{
			return notify;
		}
		

		private function getNotifyContext():Object
		{
			return context;
		}
		

		public function notifyObserver( notification:INotification ):void
		{
			this.getNotifyMethod().apply(this.getNotifyContext(),[notification]);
		}
	

		 public function compareNotifyContext( object:Object ):Boolean
		 {
		 	return object === this.context;
		 }		
	}
}