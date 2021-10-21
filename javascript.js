// const name = {
//     firstName : "ujagar",
//     lastName : "singh"
// }

// const pritintMyName = function(state, country){
//     console.log(this.firstName +' '+ this.lastName + ' ' + state + ' ' + country);
// }

// // call()
// pritintMyName.call(name, "rajasthan", "india");

// // apply()
// const args = ["kabul", "afganistan"];
// pritintMyName.apply(name, args);

// // bind()
// const _pritintMyName = pritintMyName.bind(name, ["landon", "UK"]);
// _pritintMyName();

// // custom bind() function using bind polyfills
// Function.prototype.myBind = function(...args){
//     let self = this,
//         _args = args.splice(1);
//     return function(...args2){
//         self.apply(args[0], [..._args, ...args2])
//     }
// }
// const _pritintMyName1 = pritintMyName.myBind(name, "landon");
// _pritintMyName1("United Kingdom");

const person = {
    firstName : "Lavesh",
    lastName : "Sain",
}

const fullName = function(state, country){
    console.log(this.firstName +' '+ this.lastName+' '+ state+' '+ country);
}
fullName.call(person, "rajasthan", "india");
fullName.apply(person, ["rajasthan", "india"]);
const _fullName = fullName.bind(person, "rajasthan", "Bharat");
_fullName();

Function.prototype.customBind = function(...args){
    let _this = this, _args = args.splice(1);
    return function(...args2){
        _this.apply(args[0], [..._args, ...args2])
    }
}

const customfullName = fullName.customBind(person, "rajputana", "Hindustan")
customfullName();

// // function currying 
// // using bind
// const multiPly = (x, y) => {
//     console.log('inside function >>', x * y);
//     return x * y;
// }

// const _multiPly = multiPly.bind(this, 6)
// const _res = _multiPly(5);
// console.log('outside function >>', _res);

// // using closer
// const multiPly1 = (x) => {
//     return (y) =>{
//         console.log(x * y);
//     }
// }

// const _multiPly1 = multiPly1(5)
// _multiPly1(5);

const add2Number = function(a, b){
    return a+b;
}

const _add2Number = add2Number.bind(this, 6);
const res1 = _add2Number(9);
console.log(res1);

const subtractNumber = (a) =>{
    return (b)=>{
        const _res = Math.abs(a-b)
        console.log(_res);
    }
}

const _subtractNumber = subtractNumber(5)
_subtractNumber(9)

// var objs = [ 
//     { first_nom: 'Lazslo', num: 3 },
//     { first_nom: 'Pig',    num: 0 },
//     { first_nom: 'Monkdy',  num: 0 },
//     { first_nom: 'Pirate', num: 1 }
// ];


// function mysort(a, b){
//     // debugger;
//     if(a.num < b.num){
//         return 1
//     }
//     if(a.num > b.num){
//         return -1
//     }
//     return 0;
// }
// const _objs = objs.sort( mysort );
// console.log(_objs);

// // reduce
// // debugger;
// const persons = [
//     {name : "Ujagar", workingDay : 22},
//     {name : "Lavesh", workingDay : 18},
//     {name : "Faizan", workingDay : 15},
//     {name : "Kalpna", workingDay : 0},
//     {name : "Puneet", workingDay : 22}
// ]

// const _persons = persons.reduce((totalDays, item)=> totalDays + item.workingDay, 0);
// console.log(_persons);

// const _personsGroups = persons.reduce((gruoups, item)=> {
//         const workingDays = item.workingDay;
//         if(gruoups[workingDays] == null) {gruoups[workingDays] = []};
//             gruoups[workingDays].push(item);
//         return gruoups;
//     }, {});
// console.log(_personsGroups);

// const number = [2,5,6,4,8]
// const _number = number.reduce((total,item)=>{
//     return total + item;
// },0)
// console.log(_number);

