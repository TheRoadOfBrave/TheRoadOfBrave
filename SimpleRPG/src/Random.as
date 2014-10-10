package {

	public final class Random {
		public static function get boolean() : Boolean {
			return Math.random() < .5;
		}

		public static function get wave() : int {
			return Math.random() < .5 ? -1 : 1;
		}

		public static function get color() : uint {
			return Math.random() * 16777216;
		}

		public static function integet(num : int) : int {
			return Math.random() * num;
		}

		public static function number(num : int) : Number {
			return Math.random() * num;
		}

		public static function char(...args) : String {
			return args[int(Math.random() * args.length)];
		}

		public static function string(num : int) : String {
			for (var i : uint = 0,src : String = "";i < num;i++) {
				src += charRanges("0", "9", "A", "Z", "a", "z");
			}
			return src;
		}

		public static function intRange(n1 : uint, n2 : uint) : uint {
			return Math.random() * (n2 - n1) + n1;
		}

		public static function numRange(n1 : Number, n2 : Number) : Number {
			if (n1 < 0 || n2 < 0) {
				throw new Error("参数错误：不可为负数。");
			}
			return Math.random() * (n2 - n1) + n1;
		}

		public static function charRange(s1 : String, s2 : String) : String {
			var n1 : uint = s1.charCodeAt(0),n2 : uint = s2.charCodeAt(0);
			return String.fromCharCode(int(Math.random() * (n2 - n1)) + n1);
		}

		public static function intRanges(...args) : int {
			var n1s : Array = new Array();
			var n2s : Array = new Array();
			while (args.length) {
				n1s.push(args.shift());
				n2s.push(args.shift());
			}
			var len : uint = n1s.length;
			var s1 : uint = 0, s2 : uint = 0;
			for (var i : uint = 0;i < len; i++) {
				s1 += n1s[i];
				s2 += n2s[i];
			}
			var r : int = Math.random() * (s2 - s1) + n1s[0];
			i = 0;
			while (r >= n2s[i++]) {
				r += n1s[i] - n2s[i - 1];
			}
			return r;
		}

		public static function numRanges(...args) : Number {
			var n1s : Array = new Array();
			var n2s : Array = new Array();
			while (args.length) {
				n1s.push(args.shift());
				n2s.push(args.shift());
			}
			var len : uint = n1s.length;
			var s1 : uint = 0, s2 : uint = 0;
			for (var i : uint = 0;i < len; i++) {
				s1 += n1s[i];
				s2 += n2s[i];
			} 
			do {
				var r : Number = Math.random() * (s2 - s1) + n1s[0];
				i = 0;
				while (r >= n2s[i++]) {
					r += n1s[i] - n2s[i - 1];
				}
			} while (isNaN(r));
			return r;
		}

		public static function charRanges(...args) : String {
			var n1s : Array = new Array();
			var n2s : Array = new Array();
			while (args.length) {
				n1s.push(args.shift().charCodeAt(0));
				n2s.push(args.shift().charCodeAt(0) + 1);
			}
			var len : uint = n1s.length;
			var s1 : uint = 0, s2 : uint = 0;
			for (var i : uint = 0;i < len; i++) {
				s1 += n1s[i];
				s2 += n2s[i];
			}
			var r : int = Math.random() * (s2 - s1) + n1s[0];
			i = 0;
			while (r >= n2s[i++]) {
				r += n1s[i] - n2s[i - 1];
			}
			return String.fromCharCode(r);
		}

		public static function strRanges(num : uint,...args) : String {
			var n1s : Array = new Array();
			var n2s : Array = new Array();
			while (args.length) {
				n1s.push(args.shift().charCodeAt(0));
				n2s.push(args.shift().charCodeAt(0) + 1);
			}
			var len : uint = n1s.length;
			var s1 : uint = 0, s2 : uint = 0;
			for (var i : uint = 0;i < len; i++) {
				s1 += n1s[i];
				s2 += n2s[i];
			}
			var src : String = "";
			while (num-- > 0) {
				var r : int = Math.random() * (s2 - s1) + n1s[0];
				i = 0;
				while (r >= n2s[i++]) {
					r += n1s[i] - n2s[i - 1];
				}
				src += String.fromCharCode(r);
			}
			return src;
		}
		/**
		 *
			colorRanges好像有点问题.. 会经常性的返回0 加上括号就可以解决了，忽律了优先级。 
		 * @param args
		 * @return 
		 * 
		 */
		public static function colorRanges(...args) : uint {
			return intRange(args[0], args[1] + 1) << 16 + intRange(args[2], args[3] + 1) << 8 + intRange(args[4], args[5] + 1);
		}

		public static function disorder(arr : Array) : Array {
			var len : uint = arr.length;
			var cache : *,ti : uint;
			for (var i : uint = 0;i < len;i++) {
				ti = int(Math.random() * len);
				cache = arr[i];
				arr[i] = arr[ti];
				arr[ti] = cache;
			} 
			while (--i >= 0) {	
				ti = int(Math.random() * len);
				cache = arr[i];
				arr[i] = arr[ti];
				arr[ti] = cache;
			}
			return arr;
		}

		public static function takeOut(num : uint,arr : Array) : Array {
			var newArr : Array = new Array();
			for (var i : uint = 0;i < num; i++) {
				newArr.push(arr.splice(int(Math.random() * arr.length), 1));
			}
			return newArr;
		}
		
	/*另一方法 效率稍微快一点
		public static function takeOut(num : uint,arr : Array) : Array {
			var newArr : Array = new Array(num);
			for (var i : uint = 0;i < num; i++) {
				newArr[i] = arr.splice(int(Math.random() * arr.length), 1);
			}
			return newArr;
		}*/
		public static function find(num : uint, arr : Array) : Array {
			var newArr : Array = arr.concat();
			var cache : *,ti : uint, len : uint = arr.length;
			for (var i : uint = 0;i < num; i++) {
				ti = int(Math.random() * len);
				cache = newArr[i];
				newArr[i] = newArr[ti];
				newArr[ti] = cache;
			}
			return newArr.splice(0, num);
		}
		/**
		 *一定的概率返回true,如果参数为2,那么函数有1/2的概率是返回true的 
		 * @param num
		 * @return 
		 * 
		 */		
		public static function probable(num : uint) : Boolean {
			return Math.random() < 1/num;
		}
		
		/**
		 *public static function sortition(...args) : Boolean
		函数将按概率的比例分配返回相对的索引值,如参数是20,5,25,50就会有20%的概率返回0,5%概率返回1,25%的概率返回2,50%的概率返回3
		注意:此函数如果所有参数超过100,后面超过100的部分概率会忽律,相反如果不到100,会自动补上最后一位为剩余的概率 
		 * @param args
		 * @return 
		 * 
		 */		
		public static function sortition(...args):uint {
			var num:Number = Math.random();
			var len:uint = args.length;
			for (var i:uint=0, s1:Number=0, s2:Number=0; i < len; i++) {
				s2 = s1+args[i]/100;
				if (num>=s1 && num<s2) {
					return i;
				}
				s1 = s2
			}
			return i;
		}
		
	}
}
