function memoizing(f) {
	let mem = {}
	return function(...args) {  
		if (args in mem) {return mem[args];}
		else {return mem[args] = f(...args), mem[args]}
	}
}
module.exports = memoizing