package org.puremvc.as3.core
{
	
	import org.puremvc.as3.interfaces.IModel;
	import org.puremvc.as3.interfaces.IProxy;
	
	public class Model implements IModel
	{
		public function Model( )
		{
			if (instance != null) throw Error(SINGLETON_MSG);
			instance = this;
			proxyMap = new Object();	
			initializeModel();	
		}
		
		protected function initializeModel(  ) : void 
		{
		}
				
		public static function getInstance() : IModel 
		{
			if (instance == null) instance = new Model( );
			return instance;
		}

		public function registerProxy( proxy:IProxy ) : void
		{
			proxyMap[ proxy.getProxyName() ] = proxy;
			proxy.onRegister();
		}

		public function retrieveProxy( proxyName:String ) : IProxy
		{
			return proxyMap[ proxyName ];
		}

		public function hasProxy( proxyName:String ) : Boolean
		{
			return proxyMap[ proxyName ] != null;
		}

		public function removeProxy( proxyName:String ) : IProxy
		{
			var proxy:IProxy = proxyMap [ proxyName ] as IProxy;
			if ( proxy ) 
			{
				proxyMap[ proxyName ] = null;
				proxy.onRemove();
			}
			return proxy;
		}

		// Mapping of proxyNames to IProxy instances
		protected var proxyMap : Object;

		// Singleton instance
		protected static var instance : IModel;
		
		// Message Constants
		protected const SINGLETON_MSG	: String = "Model Singleton already constructed!";

	}
}