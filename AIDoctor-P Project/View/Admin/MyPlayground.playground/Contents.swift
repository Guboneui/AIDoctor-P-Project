import UIKit

var greeting = "기침은 기도에 있는 이물질이나 분비물을 밖으로 빼내려는 인체의 방어기전입니다.\n하지만 지속적인 기침은 폐의 감염이나 염증, 또는 담배 같은 자극물질 때문에 유발될 수 있습니다.\n따라서 기침이 계속해서 나온다면 반드시 의사에게 진료를 받아보아야 합니다.\n<strong>그 전에, '애닥'이 먼저 한번 살펴보아도 될까요??</strong>"

print(greeting)



if greeting.contains("<strong>") {
    print("aaa")
} else {
    print("bb")
}



print(greeting.replacingOccurrences(of: "<strong>", with: ""))
print(greeting.replacingOccurrences(of: "</strong>", with: ""))
