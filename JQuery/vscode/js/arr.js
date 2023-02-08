//리터럴로 배열 생성
function proc1() {
    let fruits = ["사과", "바나나", 100, 12.34, true, null, "딸기"];

    // 방법 1
    /*  let ff = "";
     for (let i = 0; i < fruits.length; i++) {
         if(i>0) ff +=","; //처음 항목에는 , 없고, index = i 앞에 , 붙어서 출력
         ff += fruits[i]
     } */


    // 방법 2
    let ff = [];
    for (let i = 0; i < fruits.length; i++) {
        ff.push(fruits[i]);
    }
   // document.querySelector("#d1").textContent = ff;
    print('#d1',ff);
}

//생성자로 배열 생성1
function proc2() {
    let fruits = new Array("참외", "수박", "포도");
    let ff = ""
    for (let x in fruits) { //for in 문
        console.log("key가 무얼까?>>", x);
        if (x > 0) ff += "/"
        ff += fruits[x];
    }
   // document.querySelector('#d2').textContent = ff;
   print('#d2',ff);
}

//생성자로 배열 생성2
function proc3() {
    let fruits = new Array();
    fruits[0] = "천혜향";
    fruits[1] = "두리안";
    fruits[2] = "샤인머스캣";
    fruits[3] = "스타프루프";

    //document.querySelector('#d3').textContent = fruits;
    print('#d3',fruits);

}
function print(disp,ff) {

    document.querySelector(disp).textContent = ff;

}