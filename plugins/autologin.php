<?php
/** Logs in automatically with the dev database credentials. Dev only. */
final class AutoLoginPlugin extends Adminer\Plugin {
	function __construct() {
		if (!isset($_GET['username']) && empty($_POST)) {
			$_POST['auth'] = array(
				'driver' => 'pgsql',
				'server' => 'db',
				'username' => 'postgres',
				'password' => 'postgres',
				'db' => 'northwind',
			);
		}
	}

	// The injected login has no CSRF token.
	function verifyLoginToken() {
		return false;
	}
}

return new AutoLoginPlugin();
