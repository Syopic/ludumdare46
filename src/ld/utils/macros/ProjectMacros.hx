package ld.utils.macros;

import haxe.macro.Context;
import haxe.macro.Expr;

class ProjectMacros {
	macro public static function getBuildDate():Expr {
		var d = Date.now();
		var e = Context.makeExpr(d.toString(), Context.currentPos());
		return macro Date.fromString($e);
	}

	macro public static function getCompileParam(param:String):Expr {
		var c = Context.definedValue(param);
		return macro $v{c};
	}

	macro public static function getGitCommitHash():haxe.macro.Expr.ExprOf<String> {
		#if !display
		var process = new sys.io.Process('git', ['rev-parse', 'HEAD']);
		if (process.exitCode() != 0) {
			var message = process.stderr.readAll().toString();
			var pos = haxe.macro.Context.currentPos();
			haxe.macro.Context.error("Cannot execute `git rev-parse HEAD`. " + message, pos);
		}

		// read the output of the process
		var commitHash:String = process.stdout.readLine();

		// Generates a string expression
		return macro $v{commitHash};
		#else
		// `#if display` is used for code completion. In this case returning an
		// empty string is good enough; We don't want to call git on every hint.
		var commitHash:String = "";
		return macro $v{commitHash};
		#end
	}
}
