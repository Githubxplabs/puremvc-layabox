package org.puremvc.as3.interfaces
{

	public interface IProxy
	{

		function getProxyName():String;

		function setData( data:Object ):void;

		function getData():Object; 

		function onRegister( ):void;

		function onRemove( ):void;
	}
}