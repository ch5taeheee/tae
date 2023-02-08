//1부터 100까지의 합
function proc1() {
    let sum = 0;
    for (let i = 1; i <= 100; i++) {
        sum += i;
    }
    document.querySelector('#d1').innerText = sum;
}

//1부터 200까지의 짝수의 합

function proc2() {
    let sum = 0;
    //방식 1
    /* for(let i =2li<=200;i+=2)
    sum +=i; */

    //방식 2
    /* for(let i=1; i<=200; i++){
         if(i % 2 == 0){
             sum += i;
         }
     }
     document.querySelector('#d2').textContent = sum;
 } */

    // 방식 3
    for (let i = 1; i <= 200; i++) {
        if (i % 2 != 0) continue;
        sum += i;
    }
    document.querySelector('#d2').textContent = sum;
}

//입력된 값을 더하고 0 입력시 출력
function proc3() {
    let sum = 0; // 더해진 값
    let str = ""; // 입력된 값

    while (!0) {
        let x = parseInt(prompt("값을 입력하세요")); // promt의 반환 타입은 string>> 정수로 변환 필요
        if (x == 0) break;
        sum += x;
        str += x + " "; //문자열 더하기를 통해 입력된 값 저장
    }
    let result = "입력한 값 : " + str + "<br>";
    result += "결과 합 : " + sum;
    document.querySelector('#d3').innerHTML = result; //html 하면 br이 줄바꿈 처리 됨. text하면 br됨

}

//다중(for)i와 k를 1~10까지 더한 합이 3의 배수인 값
function proc4() {
    for (let i = 1; i <= 10; i++) {
        for (let j = 1; j <= 10; j++) {
            if ((i + j) % 3 != 0) continue;

            // result += i + "+" + j + "=" + (i+j) + "<br>";


            //backtick을 통해 문자열과 변수를 하나의 공간안에 함께 기술한다
            //변수는 ${} 안에 기술해야 함
            //백틱을 통해 만들어진 문자열을 '템플릿 리터럴' 이라고 부름

            result += `${i}  더하기  ${j} 는  ${(i + j)}  <br>`; //' ' 하나의 문자열을 만든다? 변수는 ${} 안에 넣는다.
        }
        result += "<br>";
    }
    document.querySelector('#d4').innerHTML = result;

}

//1부터 100까지 2와 3의 배수인 값
function proc5() {
    let result = "";
    for (let i = 1; i <= 100; i++) {
        if (i % 2 == 0 && i % 3 == 0) result += i + " ";
    }
    document.querySelector('#d5').innerHTML = result;


}


//두 수의 합이 100이상일 때 출력
function proc6() {
    let str = "두수의 합이 100이상인 것 : ";
    while (!0) {
        let x = parseInt(prompt("첫번째 값 입력: "));
        let y = parseInt(prompt("두번째 값 입력: "));

        if (x == 0 && y == 0) break; //빠져나갈 조건

        let sum = x + y;
        //if(sum >= 100) str += x + "+" + y + "=" + (x+y) + "<vr>";
        if (sum >= 100) str += `${x} + ${y} = ${x + y} <br>`
    }

//화면에 표시할 컨텐츠 내용 중 tag 존재 시 innerHTML 을 사용해야 하지만 권장하는 메소드가 아님
// 대안으로 활용할 수 있는 메소드 >> insertAdjacentHTML()을 사용해야 하며 관련 정보는 mdn에서 확인합시다..
// 현재는 테스트 예제를 작성 중이므로 innerHTML을 그냥 사용.....^^;
//document.querySelector('#d6').innerHTML = str;
document.querySelector('#d6').insertAdjacentHTML('afterbegin', str); //innerHTML 대신 사용 권장;



}