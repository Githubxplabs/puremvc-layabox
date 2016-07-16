package org.puremvc.as3.core
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.IController;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.IView;
	import org.puremvc.as3.patterns.observer.Observer;
	
	public class Controller implements IController
	{
		
		public function Controller( )
		{
			if (instance != null) throw Error(SINGLETON_MSG);
			instance = this;
			commandMap = new Object();	
			initializeController();	
		}
		
		protected function initializeController(  ) : void 
		{
			view = View.getInstance();
		}
	
		public static function getInstance() : IController
		{
			if ( instance == null ) instance = new Controller( );
			return instance;
		}
		
		public function executeCommand( note : INotification ) : void
		{
			var commandClassRef : Class = commandMap[ note.getName() ];
			if ( commandClassRef == null ) return;

			var commandInstance : ICommand = new commandClassRef();
			commandInstance.execute( note );
		}

		public function registerCommand( notificationName : String, commandClassRef : Class ) : void
		{
			if ( commandMap[ notificationName ] == null ) {
				view.registerObserver( notificationName, new Observer( executeCommand, this ) );
			}
			commandMap[ notificationName ] = commandClassRef;
		}
		
		public function hasCommand( notificationName:String ) : Boolean
		{
			return commandMap[ notificationName ] != null;
		}
		
		public function removeCommand( notificationName : String ) : void
		{
			// if the Command is registered...
			if ( hasCommand( notificationName ) )
			{
				// remove the observer
				view.removeObserver( notificationName, this );
							
				// remove the command
				commandMap[ notificationName ] = null;
			}
		}
		
		// Local reference to View 
		protected var view : IView;
		
		// Mapping of Notification names to Command Class references
		protected var commandMap : Object;

		// Singleton instance
		protected static var instance : IController;

		// Message Constants
		protected const SINGLETON_MSG : String = "Controller Singleton already constructed!";

	}
}