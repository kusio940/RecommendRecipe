//
//  RecipeCardViewController+Extension.swift
//  RecommendRecipe
//
//  Created by 宮永祐介 on 2020/10/02.
//  Copyright © 2020 Miyanaga. All rights reserved.
//

import Foundation

extension RecipeCardViewController{

    //CategoryTypeに振り分けた、楽天レシピのカテゴリ数（例：meat 52 →楽天レシピの52このカテゴリをまとめてmeatとして扱う）
    enum IncludedCategoryCount: String{
        case 肉
        case 魚
        case 卵
        case 豆腐
        case ご飯もの
        case 粉物
        case 麺類
        case パン
        case スープ
        case 鍋
        case 野菜
        case サラダ
        case スイーツ
        case 果物
        case 海外料理
        case 弁当
        
        var CategoryCount: Int {
            switch self {
            case .肉:
                        return 52
            case .魚:
                        return 41
            case .卵:
                        return 19
            case .豆腐:
                        return 13
            case .ご飯もの:
                        return 22
            case .粉物:
                        return 4
            case .麺類:
                        return 43
            case .パン:
                        return 16
            case .スープ:
                        return 25
            case .鍋:
                        return 29
            case .野菜:
                        return 30
            case .サラダ:
                        return 20
            case .スイーツ:
                        return 21
            case .果物:
                        return 14
            case .海外料理:
                        return 19
            case .弁当:
                        return 12
            }
        }
    }
    
    enum RakutenRecipeCategoryId: String{
        case 肉
        case 魚
        case 卵
        case 豆腐
        case ご飯もの
        case 粉物
        case 麺類
        case パン
        case スープ
        case 鍋
        case 野菜
        case サラダ
        case スイーツ
        case 果物
        case 海外料理
        case 弁当
        
        func getCategoryId(smallCategoryNumber: Int) -> String? {
            switch self {
            case .肉:
                        return meatCategory(rawValue: smallCategoryNumber)?.Id
            case .魚:
                        return fishCategory(rawValue: smallCategoryNumber)?.Id
            case .卵:
                        return eggCategory(rawValue: smallCategoryNumber)?.Id
            case .豆腐:
                        return tofuCategory(rawValue: smallCategoryNumber)?.Id
            case .ご飯もの:
                        return riceCategory(rawValue: smallCategoryNumber)?.Id
            case .粉物:
                        return powderCategory(rawValue: smallCategoryNumber)?.Id
            case .麺類:
                        return noodleCategory(rawValue: smallCategoryNumber)?.Id
            case .パン:
                        return breadCategory(rawValue: smallCategoryNumber)?.Id
            case .スープ:
                        return soupCategory(rawValue: smallCategoryNumber)?.Id
            case .鍋:
                        return casseroleCategory(rawValue: smallCategoryNumber)?.Id
            case .野菜:
                        return vegetableCategory(rawValue: smallCategoryNumber)?.Id
            case .サラダ:
                        return saladCategory(rawValue: smallCategoryNumber)?.Id
            case .スイーツ:
                        return sweetsCategory(rawValue: smallCategoryNumber)?.Id
            case .果物:
                        return fruitCategory(rawValue: smallCategoryNumber)?.Id
            case .海外料理:
                        return overseasCuisineCategory(rawValue: smallCategoryNumber)?.Id
            case .弁当:
                        return bentoCategory(rawValue: smallCategoryNumber)?.Id
            }
        }
        
        private enum meatCategory: Int
        {
            case beef
            case pork
            case chicken
            case mincedMeat
            case bacon
            case sausageWiener
            case ham
            case otherMeat
            case hamburger
            case nikujaga
            case porkGinger
            case dumplings
            case friedChicken
            case croquette
            case roastBeef
            case kakuniPork
            case chickenNanban
            case stuffedPeppers
            case cabbageRolls
            case spareRibs
            case roastChicken
            case stewedWith
            case meatballsAndMeatDumplings
            case meatloaf
            case stewedBeefTendon
            case tonkatsu
            case porkSaute
            case tsukune
            case charSiu
            case boiledPork
            case steak
            case chickenDish
            case tonteki
            case meatRoll
            case roastPork
            case easyChickenDish
            case easyPorkDish
            case sweetAndSourPork
            case chinjaolose
            case genghiskhan
            case piccata
            case bulgogi
            case damgyeopsal
            case dakgalbi
            case cheesedakgalbi
            case springRolls
            case meatBun
            case shumai
            case hoikoro
            case bonBonChicken
            case deepFriedChicken
            case mouthWaterChicken

            var Id: String {
                switch self {
                case .beef:                          return "10-275"
                case .pork:                          return "10-276"
                case .chicken:                       return "10-277"
                case .mincedMeat:                    return "10-278"
                case .bacon:                         return "10-68"
                case .sausageWiener:                 return "10-66"
                case .ham:                           return "10-67"
                case .otherMeat:                     return "10-69"
                case .hamburger:                     return "30-302"
                case .nikujaga:                      return "30-305"
                case .porkGinger:                    return "30-301"
                case .dumplings:                     return "30-309"
                case .friedChicken:                  return "30-310"
                case .croquette:                     return "31-318"
                case .roastBeef:                     return "31-319"
                case .kakuniPork:                    return "31-320"
                case .chickenNanban:                 return "31-321"
                case .stuffedPeppers:                return "31-323"
                case .cabbageRolls:                  return "31-324"
                case .spareRibs:                     return "31-325"
                case .roastChicken:                  return "31-326"
                case .stewedWith:                    return "31-327"
                case .meatballsAndMeatDumplings:     return "31-328"
                case .meatloaf:                      return "31-329"
                case .stewedBeefTendon:              return "31-330"
                case .tonkatsu:                      return "31-331"
                case .porkSaute:                     return "31-332"
                case .tsukune:                       return "31-333"
                case .charSiu:                       return "31-334"
                case .boiledPork:                    return "31-322"
                case .steak:                         return "31-335"
                case .chickenDish:                   return "31-718"
                case .tonteki:                       return "31-719"
                case .meatRoll:                      return "31-720"
                case .roastPork:                     return "36-493"
                case .easyChickenDish:               return "36-494"
                case .easyPorkDish:                  return "41-531"
                case .sweetAndSourPork:              return "41-532"
                case .chinjaolose:                   return "48-611"
                case .genghiskhan:                   return "43-573"
                case .piccata:                       return "42-555"
                case .bulgogi:                       return "42-559"
                case .damgyeopsal:                   return "42-561"
                case .dakgalbi:                      return "42-714"
                case .cheesedakgalbi:                return "41-546"
                case .springRolls:                   return "41-547"
                case .meatBun:                       return "41-548"
                case .shumai:                        return "41-537"
                case .hoikoro:                       return "41-539"
                case .bonBonChicken:                 return "41-542"
                case .deepFriedChicken:              return "41-713"
                case .mouthWaterChicken:             return "30-302"
                }
            }
        }
        
        private enum fishCategory: Int
        {
            case salmon
            case sardines
            case mackerel
            case horseMackerel
            case yellowtail
            case pacificSaury
            case seaBream
            case tuna
            case tara
            case otherFish
            case squid
            case octopus
            case shrimp
            case crab
            case oysters
            case shellfish
            case roe
            case otherSeafood
            case yellowtailRadish
            case teriyakiYellowtail
            case mackerelMiso
            case boiledFish
            case steamedClams
            case salmonMeuniere
            case nanbanzuke
            case grilledFish
            case grilledSalmon
            case sardineFishBall
            case katsuoNoTataki
            case boiledSardinesWithPlums
            case turnipSteamed
            case otherFishDishes
            case easyFishDishes
            case boiledStrawberry
            case chanChanYaki
            case meuniere
            case acquaPazza
            case carpaccio
            case gejang
            case shrimpChili
            case creamShrimp
            
            var Id: String {
                switch self {
                case .salmon:                   return "11-70"
                case .sardines:                 return "11-71"
                case .mackerel:                 return "11-72"
                case .horseMackerel:            return "11-73"
                case .yellowtail:               return "11-74"
                case .pacificSaury:             return "11-75"
                case .seaBream:                 return "11-76"
                case .tuna:                     return "11-77"
                case .tara:                     return "11-443"
                case .otherFish:                return "11-78"
                case .squid:                    return "11-80"
                case .octopus:                  return "11-81"
                case .shrimp:                   return "11-79"
                case .crab:                     return "11-83"
                case .oysters:                  return "11-444"
                case .shellfish:                return "11-82"
                case .roe:                      return "11-445"
                case .otherSeafood:             return "11-446"
                case .yellowtailRadish:         return "32-336"
                case .teriyakiYellowtail:       return "32-337"
                case .mackerelMiso:             return "32-338"
                case .boiledFish:               return "32-339"
                case .steamedClams:             return "32-340"
                case .salmonMeuniere:           return "32-341"
                case .nanbanzuke:               return "32-342"
                case .grilledFish:              return "32-343"
                case .grilledSalmon:            return "32-344"
                case .sardineFishBall:          return "32-345"
                case .katsuoNoTataki:           return "32-346"
                case .boiledSardinesWithPlums:  return "32-347"
                case .turnipSteamed:            return "32-348"
                case .otherFishDishes:          return "32-349"
                case .easyFishDishes:           return "36-495"
                case .boiledStrawberry:         return "48-625"
                case .chanChanYaki:             return "48-612"
                case .meuniere:                 return "44-587"
                case .acquaPazza:               return "43-572"
                case .carpaccio:                return "43-577"
                case .gejang:                   return "42-564"
                case .shrimpChili:              return "41-535"
                case .creamShrimp:              return "41-536"
                }
            }
        }
        
        private enum eggCategory: Int
        {
            case boiledEgg
            case hotSpringEgg
            case falfBoiledEgg
            case rolledEgg
            case steamedEggCustard
            case quiche
            case omelette
            case crabBalls
            case scrambledEgg
            case seasonedEgg
            case friedEgg
            case niladama
            case poachedEgg
            case scotchEgg
            case eggBinding
            case thinlyFriedEgg
            case roastedEgg
            case otherEggDishe
            case seasonedDgg
            
            var Id: String {
                switch self {
                case .boiledEgg:            return "33-350"
                case .hotSpringEgg:         return "33-351"
                case .falfBoiledEgg:        return "33-352"
                case .rolledEgg:            return "33-353"
                case .steamedEggCustard:    return "33-354"
                case .quiche:               return "33-355"
                case .omelette:             return "33-356"
                case .crabBalls:            return "33-357"
                case .scrambledEgg:         return "33-358"
                case .seasonedEgg:          return "33-359"
                case .friedEgg:             return "33-360"
                case .niladama:             return "33-361"
                case .poachedEgg:           return "33-362"
                case .scotchEgg:            return "33-363"
                case .eggBinding:           return "33-364"
                case .thinlyFriedEgg:       return "33-365"
                case .roastedEgg:           return "33-366"
                case .otherEggDishe:        return "33-367"
                case .seasonedDgg:          return "33-721"
                }
            }
        }
        
        private enum tofuCategory: Int
        {
            case okara
            case stsuage
            case natto
            case koyaTofu
            case soyMilk
            case cottonTofu
            case silkenTofu
            case friedTofu
            case soyMeat
            case saltedTofu
            case otherTofu
            case tofuDish
            case marboTofu
            
            var Id: String {
                switch self {
                case .okara:        return "33-352"
                case .stsuage:      return "33-353"
                case .natto:        return "33-354"
                case .koyaTofu:     return "33-355"
                case .soyMilk:      return "33-356"
                case .cottonTofu:   return "33-357"
                case .silkenTofu:   return "33-358"
                case .friedTofu:    return "33-359"
                case .soyMeat:      return "33-360"
                case .saltedTofu:   return "33-361"
                case .otherTofu:    return "33-362"
                case .tofuDish:     return "33-363"
                case .marboTofu:    return "33-364"
                }
            }
        }
        
        private enum riceCategory: Int
        {
            case omeletRice
            case friedRice
            case paella
            case tacoRice
            case chickenRice
            case hayashiRice
            case locoMoco
            case pilaf
            case hashedBeef
            case otherRice
            case sushi
            case bowl
            case curry
            case gyudon
            case oyakodon
            case otherRiceDishes
            case ikameshi
            case kiritanpo
            case hitsumabushi
            case risotto
            case bibimbap
            case chimaki
            
            var Id: String {
                switch self {
                case .omeletRice:       return "14-121"
                case .friedRice:        return "14-131"
                case .paella:           return "14-126"
                case .tacoRice:         return "14-124"
                case .chickenRice:      return "14-122"
                case .hayashiRice:      return "14-123"
                case .locoMoco:         return "14-125"
                case .pilaf:            return "14-127"
                case .hashedBeef:       return "14-368"
                case .otherRice:        return "14-128"
                case .sushi:            return "14-129"
                case .bowl:             return "14-130"
                case .curry:            return "30-307"
                case .gyudon:           return "30-303"
                case .oyakodon:         return "30-304"
                case .otherRiceDishes:  return "14-271"
                case .ikameshi:         return "48-619"
                case .kiritanpo:        return "48-622"
                case .hitsumabushi:     return "48-616"
                case .risotto:          return "43-578"
                case .bibimbap:         return "42-552"
                case .chimaki:          return "41-544"
                }
            }
        }
        
        private enum powderCategory: Int
        {
            case okonomiyaki
            case takoyaki
            case akashiyaki
            case chijimi
            
            var Id: String {
                switch self {
                case .okonomiyaki:  return "16-385"
                case .takoyaki:     return "16-386"
                case .akashiyaki:   return "48-618"
                case .chijimi:      return "42-551"
                }
            }
        }
        
        private enum noodleCategory: Int
        {
            case carbonara
            case mincedMeatSauce
            case napolitan
            case peperoncino
            case genovese
            case pescatore
            case tarakoPasta
            case vongole
            case arrabiata
            case tomatoCreamPasta
            case nattoPasta
            case tomatoPasta
            case creamPasta
            case saltPasta
            case cheesePasta
            case basilSaucePasta
            case japaneseStylePasta
            case mushroomPasta
            case tunaPasta
            case coldpasta
            case soupPasta
            case otherPasta
            case gnocchi
            case lasagne
            case ravioli
            case macaroniPenne
            case gratin
            case udon
            case soba
            case somen
            case yakisoba
            case ramen
            case hiyashiChuka
            case tsukemen
            case otherNoodles
            case saraUdon
            case champon
            case hoto
            case somenChanpuru
            case coldNoodles
            case sunRattan
            case jarJarnoodles
            case danDanNoodles
            
            var Id: String {
                switch self {
                case .carbonara:            return "15-687"
                case .mincedMeatSauce:      return "15-137"
                case .napolitan:            return "15-676"
                case .peperoncino:          return "15-681"
                case .genovese:             return "15-369"
                case .pescatore:            return "15-677"
                case .tarakoPasta:          return "15-683"
                case .vongole:              return "15-682"
                case .arrabiata:            return "15-678"
                case .tomatoCreamPasta:     return "15-679"
                case .nattoPasta:           return "15-684"
                case .tomatoPasta:          return "15-680"
                case .creamPasta:           return "15-138"
                case .saltPasta:            return "15-139"
                case .cheesePasta:          return "15-140"
                case .basilSaucePasta:      return "15-141"
                case .japaneseStylePasta:   return "15-142"
                case .mushroomPasta:        return "15-685"
                case .tunaPasta:            return "15-686"
                case .coldpasta:            return "15-143"
                case .soupPasta:            return "15-145"
                case .otherPasta:           return "15-146"
                case .gnocchi:              return "15-147"
                case .lasagne:              return "15-151"
                case .ravioli:              return "15-382"
                case .macaroniPenne:        return "13-479"
                case .gratin:               return "30-306"
                case .udon:                 return "16-152"
                case .soba:                 return "16-153"
                case .somen:                return "16-154"
                case .yakisoba:             return "16-155"
                case .ramen:                return "16-156"
                case .hiyashiChuka:         return "16-383"
                case .tsukemen:             return "16-384"
                case .otherNoodles:         return "16-272"
                case .saraUdon:             return "48-621"
                case .champon:              return "48-617"
                case .hoto:                 return "48-615"
                case .somenChanpuru:        return "47-603"
                case .coldNoodles:          return "42-557"
                case .sunRattan:            return "41-545"
                case .jarJarnoodles:        return "41-538"
                case .danDanNoodles:        return "41-541"
                }
            }
        }
        
        private enum breadCategory: Int
        {
            case sandwich
            case frenchToast
            case bread
            case steamedBread
            case hotSandwich
            case sideDishBread
            case sweetBread
            case plainBread
            case croissantDanish
            case hardBread
            case naturalYeastBread
            case breadFromAllOverTheWorld
            case healthyBread
            case carapan
            case otherBread
            case paninoPanini
            
            var Id: String {
                switch self {
                case .sandwich:                 return "22-432"
                case .frenchToast:              return "22-433"
                case .bread:                    return "22-434"
                case .steamedBread:             return "22-435"
                case .hotSandwich:              return "22-436"
                case .sideDishBread:            return "22-229"
                case .sweetBread:               return "22-221"
                case .plainBread:               return "22-220"
                case .croissantDanish:          return "22-222"
                case .hardBread:                return "22-219"
                case .naturalYeastBread:        return "22-223"
                case .breadFromAllOverTheWorld: return "22-227"
                case .healthyBread:             return "22-231"
                case .carapan:                  return "22-437"
                case .otherBread:               return "22-230"
                case .paninoPanini:             return "43-575"
                }
            }
        }
        
        private enum soupCategory: Int
        {
            case misoSoup
            case butajiru
            case kenchinJiru
            case soup
            case pumpkinSoup
            case vegetableSoup
            case chowderClamChowder
            case cornSoupPotage
            case tomatoSoup
            case consommeSoup
            case creamSoup
            case chineseSoup
            case japaneseStyleSoup
            case koreanStyleSoup
            case otherSoups
            case potaufeu
            case otherJiru
            case stew
            case senbeiJiru
            case suiton
            case ratatouille
            case minestrone
            case sundubu
            case bowser
            case noppeSoup
            
            var Id: String {
                switch self {
                case .misoSoup:             return "17-159"
                case .butajiru:             return "17-161"
                case .kenchinJiru:          return "17-387"
                case .soup:                 return "17-160"
                case .pumpkinSoup:          return "17-388"
                case .vegetableSoup:        return "17-169"
                case .chowderClamChowder:   return "17-389"
                case .cornSoupPotage:       return "17-171"
                case .tomatoSoup:           return "17-168"
                case .consommeSoup:         return "17-167"
                case .creamSoup:            return "17-170"
                case .chineseSoup:          return "17-164"
                case .japaneseStyleSoup:    return "17-165"
                case .koreanStyleSoup:      return "17-166"
                case .otherSoups:           return "17-173"
                case .potaufeu:             return "17-390"
                case .otherJiru:            return "17-162"
                case .stew:                 return "30-308"
                case .senbeiJiru:           return "48-620"
                case .suiton:               return "48-614"
                case .ratatouille:          return "44-583"
                case .minestrone:           return "43-570"
                case .sundubu:              return "42-565"
                case .bowser:               return "42-560"
                case .noppeSoup:            return "48-623"
                }
            }
        }
        
        private enum casseroleCategory: Int
        {
            case sukiyaki
            case shabuShabu
            case oden
            case yosenabe
            case kimchiPot
            case tomatoPot
            case curryPot
            case soyMilkHotPot
            case motsunabe
            case ishikariNabe
            case mizutaki
            case yudofu
            case kiritanpo
            case mizoreNabe
            case hotPot
            case KoreanHotPot
            case chankoNabe
            case oysterHotPot
            case crabPot
            case negimaHotPot
            case duckHotPot
            case ankoNabe
            case whiteMisoHotPot
            case millefeuillePot
            case steamingPot
            case otherPots
            case gamjatang
            case tenjanchige
            case otherJjigae
            
            var Id: String {
                switch self {
                case .sukiyaki:         return "23-392"
                case .shabuShabu:       return "23-394"
                case .oden:             return "23-391"
                case .yosenabe:         return "23-399"
                case .kimchiPot:        return "23-395"
                case .tomatoPot:        return "23-401"
                case .curryPot:         return "23-404"
                case .soyMilkHotPot:    return "23-397"
                case .motsunabe:        return "23-393"
                case .ishikariNabe:     return "23-403"
                case .mizutaki:         return "23-400"
                case .yudofu:           return "23-396"
                case .kiritanpo:        return "23-405"
                case .mizoreNabe:       return "23-407"
                case .hotPot:           return "23-412"
                case .KoreanHotPot:     return "23-406"
                case .chankoNabe:       return "23-398"
                case .oysterHotPot:     return "23-413"
                case .crabPot:          return "23-411"
                case .negimaHotPot:     return "23-409"
                case .duckHotPot:       return "23-410"
                case .ankoNabe:         return "23-402"
                case .whiteMisoHotPot:  return "23-698"
                case .millefeuillePot:  return "23-723"
                case .steamingPot:      return "23-408"
                case .otherPots:        return "23-234"
                case .gamjatang:        return "42-562"
                case .tenjanchige:      return "42-566"
                case .otherJjigae:      return "42-567"
                }
            }
        }
        
        private enum vegetableCategory: Int
        {
            case eggplant
            case pumpkin
            case radish
            case cucumber
            case potatoes
            case sweetPotatoes
            case cabbage
            case chineseCabbage
            case tomatoes
            case beanSprouts
            case japaneseMustardSpinach
            case spinach
            case burdock
            case avocado
            case onions
            case broccoli
            case carrot
            case springVegetables
            case summerVegetables
            case autumnVegetables
            case winterVegetables
            case mushrooms
            case herbs
            case otherVegetables
            case potatoDishes
            case jibuni
            case chikuzenni
            case bagnaCauda
            case goyaChanpuru
            case chopSuey
            
            var Id: String {
                switch self {
                case .eggplant:                 return "12-447"
                case .pumpkin:                  return "12-448"
                case .radish:                   return "12-449"
                case .cucumber:                 return "12-450"
                case .potatoes:                 return "12-97"
                case .sweetPotatoes:            return "12-452"
                case .cabbage:                  return "12-98"
                case .chineseCabbage:           return "12-453"
                case .tomatoes:                 return "12-454"
                case .beanSprouts:              return "12-99"
                case .japaneseMustardSpinach:   return "12-456"
                case .spinach:                  return "12-457"
                case .burdock:                  return "12-455"
                case .avocado:                  return "12-451"
                case .onions:                   return "12-96"
                case .broccoli:                 return "12-458"
                case .carrot:                   return "12-95 "
                case .springVegetables:         return "12-100"
                case .summerVegetables:         return "12-101"
                case .autumnVegetables:         return "12-102"
                case .winterVegetables:         return "12-103"
                case .mushrooms:                return "12-105"
                case .herbs:                    return "12-107"
                case .otherVegetables:          return "12-104"
                case .potatoDishes:             return "30-717"
                case .jibuni:                   return "48-624"
                case .chikuzenni:               return "48-613"
                case .bagnaCauda:               return "43-571"
                case .goyaChanpuru:             return "47-602"
                case .chopSuey:                 return "41-533"
                }
            }
        }
        
        private enum saladCategory: Int
        {
            case potatoSalad
            case TaramaSalad
            case macaroniSalad
            case spaghettiSalad
            case caesarSalad
            case radishSalad
            case vermicelliSalad
            case coleslaw
            case carrotTrape
            case pumpkinSalad
            case burdockSalad
            case cobbSalad
            case hotSalad
            case jarSalad
            case material
            case seasoning
            case mayonnaise
            case nampla
            case otherSalads
            case choregiSalad
            
            var Id: String {
                switch self {
                case .potatoSalad:      return "18-415"
                case .TaramaSalad:      return "18-424"
                case .macaroniSalad:    return "18-421"
                case .spaghettiSalad:   return "18-189"
                case .caesarSalad:      return "18-187"
                case .radishSalad:      return "18-417"
                case .vermicelliSalad:  return "18-416"
                case .coleslaw:         return "18-418"
                case .carrotTrape:      return "18-722"
                case .pumpkinSalad:     return "18-419"
                case .burdockSalad:     return "18-420"
                case .cobbSalad:        return "18-423"
                case .hotSalad:         return "18-190"
                case .jarSalad:         return "18-703"
                case .material:         return "18-184"
                case .seasoning:        return "18-188"
                case .mayonnaise:       return "18-185"
                case .nampla:           return "18-186"
                case .otherSalads:      return "18-191"
                case .choregiSalad:     return "42-556"
                }
            }
        }
        
        private enum sweetsCategory: Int
        {
            case cookies
            case sweetPotato
            case cheesecake
            case chiffonCake
            case poundCake
            case cake
            case pancakes
            case tartPie
            case chocolate
            case scone
            case bakedConfectionery
            case pudding
            case donuts
            case creamPuff
            case jelly
            case ice
            case japaneseSweets
            case otherSweets
            case pannaCotta
            case tiramisu
            case anninTofu
            
            var Id: String {
                switch self {
                case .cookies:              return "21-204"
                case .sweetPotato:          return "21-440"
                case .cheesecake:           return "21-205"
                case .chiffonCake:          return "21-438"
                case .poundCake:            return "21-439"
                case .cake:                 return "21-206"
                case .pancakes:             return "21-215"
                case .tartPie:              return "21-207"
                case .chocolate:            return "21-208"
                case .scone:                return "21-209"
                case .bakedConfectionery:   return "21-210"
                case .pudding:              return "21-211"
                case .donuts:               return "21-216"
                case .creamPuff:            return "21-212"
                case .jelly:                return "21-441"
                case .ice:                  return "21-442"
                case .japaneseSweets:       return "21-214"
                case .otherSweets:          return "21-217"
                case .pannaCotta:           return "43-580"
                case .tiramisu:             return "43-581"
                case .anninTofu:            return "41-540"
                }
            }
        }
        
        private enum fruitCategory: Int
        {
            case apples
            case yuzu
            case persimmon
            case lemon
            case banana
            case blueberries
            case grapefruit
            case kiwi
            case orange
            case springFruit
            case summerFruits
            case autumnFruits
            case winterFruits
            case otherFruits
            
            var Id: String {
                switch self {
                case .apples:       return "34-688"
                case .yuzu:         return "34-459"
                case .persimmon:    return "34-460"
                case .lemon:        return "34-461"
                case .banana:       return "34-697"
                case .blueberries:  return "34-462"
                case .grapefruit:   return "34-690"
                case .kiwi:         return "34-691"
                case .orange:       return "34-702"
                case .springFruit:  return "34-692"
                case .summerFruits: return "34-693"
                case .autumnFruits: return "34-689"
                case .winterFruits: return "34-695"
                case .otherFruits:  return "34-696"
                }
            }
        }
        
        private enum overseasCuisineCategory: Int
        {
            case spanishFood
            case britishFood
            case russianFood
            case germanFood
            case turkish
            case thaiFood
            case indianFood
            case vietnameseFood
            case mexicanFood
            case cheeseFondue
            case terrine
            case bouillabaisse
            case bisque
            case marinated
            case galette
            case otherFrenchCuisine
            case otherKoreanFood
            case otherItalianFood
            case otherChineseFood
            
            var Id: String {
                switch self {
                case .spanishFood:          return "25-256"
                case .britishFood:          return "25-701"
                case .russianFood:          return "25-248"
                case .germanFood:           return "25-255"
                case .turkish:              return "25-257"
                case .thaiFood:             return "46-596"
                case .indianFood:           return "46-597"
                case .vietnameseFood:       return "46-598"
                case .mexicanFood:          return "46-599"
                case .cheeseFondue:         return "44-584"
                case .terrine:              return "44-585"
                case .bouillabaisse:        return "44-586"
                case .bisque:               return "44-588"
                case .marinated:            return "44-589"
                case .galette:              return "44-590"
                case .otherFrenchCuisine:   return "44-591"
                case .otherKoreanFood:      return "42-568"
                case .otherItalianFood:     return "43-582"
                case .otherChineseFood:     return "41-549"
                }
            }
        }
        
        private enum bentoCategory: Int
        {
            case kyaraben
            case lunchBoxSideDish
            case sportsDayLunch
            case cherryblossomViewingLunch
            case picnicLunchBox
            case colorCodedSideDishes
            case preMade
            case clearanceSideDish
            case sideDishForReuse
            case childrensLunch
            case adultLunchBox
            case clubActivities

            var Id: String {
                switch self {
                case .kyaraben:                     return "20-485"
                case .lunchBoxSideDish:             return "20-197"
                case .sportsDayLunch:               return "20-486"
                case .cherryblossomViewingLunch:    return "20-487"
                case .picnicLunchBox:               return "20-488"
                case .colorCodedSideDishes:         return "20-198"
                case .preMade:                      return "20-199"
                case .clearanceSideDish:            return "20-200"
                case .sideDishForReuse:             return "20-201"
                case .childrensLunch:               return "20-202"
                case .adultLunchBox:                return "20-203"
                case .clubActivities:               return "20-258"
                }
            }
        }
    }
}
