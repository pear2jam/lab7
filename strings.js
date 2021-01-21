function get_strings(n, len) {

    if (!Number.isInteger(n) || !Number.isInteger(len)) {throw new TypeError('invalid argument types');}
    
	if (n <= 0 || len <= 0) {throw new Error('invalid argument values');}

	let str_arr = Array(n).fill('');

	str_arr.forEach((i, index) => {
		for (let i = 0; i < len; ++i) {str_arr[index] += String.fromCharCode(Math.floor((127 - 33) * Math.random()) + 33);}
	})
	return str_arr
}

ans = get_strings(Number(prompt()),Number(prompt()));
for (let i = 0; i < ans.length; ++i){
    console.log(ans[i]);
}