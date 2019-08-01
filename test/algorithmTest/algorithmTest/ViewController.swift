//
//  ViewController.swift
//  algorithmTest
//
//  Created by zhangyu on 2018/10/25.
//  Copyright © 2018 zhangyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var arr: [Int] = [24, 14, 55, 62, 32, 48, 15, 33, 61, 93, 35, 58, 41]
        print(heapSort(datas: &arr))
        print(shellSort(oriArr: &arr))
        print(bubbleSort(oriArr: &arr))
        print(selectionSort(oriArr: &arr))
        print(insertionSort(oriArr: &arr))
        mergeSort(oriArr: &arr)
    }
    
    func swap( arr: inout [Int], a: Int, b: Int) {
        let temp = arr[b]
        arr[b] = arr[a]
        arr[a] = temp
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var lastNumDic: [Int:Int] = [:]
        for item in nums.enumerated() {
            let lastNum = target - item.element
            if lastNumDic.keys.contains(lastNum) {
                return [lastNumDic[lastNum]!, item.offset]
            }
            lastNumDic[item.element] = item.offset
        }
        return []
    }
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var ans = 0
        var sDic: [Character: Int] = [:]
        var i = 0, j = 0
        for item in s.enumerated() {
            if let v = sDic[item.element] {
                i = max(v, i)
            }
            ans = max(ans, j - i + 1)
            sDic[item.element] = item.offset
        }
        return ans
    }
    
    func longestPalindrome(_ s: String) -> String {
        
        func expandAroundCenter(str: String, idxL: Int, idxR: Int) -> Int {
            var left = idxL, right = idxR
            while left >= 0 && right < str.count && (str[String.Index(encodedOffset: left)] == str[String.Index(encodedOffset: right)]) {
                left -= 1
                right += 1
            }
            return right - left - 1
        }
        
        if s.count < 1 { return "" }
        var start = 0, end = 0
        for i in 0 ..< s.count {
            let len1 = expandAroundCenter(str: s, idxL: i, idxR: i)
            let len2 = expandAroundCenter(str: s, idxL: i, idxR: i + 1)
            let maxLen = max(len1, len2)
            if maxLen > end - start {
                start = i - (maxLen - 1) / 2
                end = i + maxLen / 2
            }
        }
        return String(s[String.Index.init(encodedOffset: start)...String.Index.init(encodedOffset: end)])
    }

    var length = 0
    func heapSort(datas: inout [Int]) -> [Int] {

        
        func heapify(arr: inout [Int], i: Int) {
            var node = i, left = 2 * i + 1, right = 2 * i + 2
            if left < length && arr[left] > arr[node] {
                node = left
            }
            if right < length && arr[right] > arr[node] {
                node = right
            }
            if node != i {
                swap(arr: &arr, a: i, b: node)
                heapify(arr: &arr, i: node)
            }
        }
        
        func buildMaxHeap(oriArr: inout [Int]) {
            length = oriArr.count
            for i in (0...length / 2 - 1).reversed() {
                heapify(arr: &oriArr, i: i)
            }
        }
        
        buildMaxHeap(oriArr: &datas)
        
        for i in (1...length - 1).reversed() {
            swap(arr: &datas, a: i, b: 0)
            length -= 1
            heapify(arr: &datas, i: 0)
        }
        
        return datas
    }
    
    
    func shellSort(oriArr: inout [Int]) -> [Int] {
        var gap = oriArr.count / 2
        while gap > 0 {
            for i in gap..<oriArr.count {
                var j = i
                while j - gap >= 0 && oriArr[j] < oriArr[j - gap] {
                    let temp = oriArr[j]
                    oriArr[j] = oriArr[j - gap]
                    oriArr[j - gap] = temp
                    j -= gap
                }
            }
            gap /= 2
        }
        return oriArr
    }
    
    func bubbleSort(oriArr: inout [Int]) -> [Int] {
        var i = 0
        while i < oriArr.count - 1 {
            var j = 0
            while j < oriArr.count - i - 1 {
                if oriArr[j + 1] < oriArr[j] {
                    let temp = oriArr[j]
                    oriArr[j] = oriArr[j + 1]
                    oriArr[j + 1] = temp
                }
                j += 1
            }
            i += 1
        }
        return oriArr
    }
    
    func selectionSort(oriArr: inout [Int]) -> [Int] {
        for i in 0 ..< oriArr.count - 1 {
            var minIdx = i
            for j in i + 1 ..< oriArr.count {
                if oriArr[minIdx] > oriArr[j] {
                    minIdx = j
                }
            }
            let temp = oriArr[i]
            oriArr[i] = oriArr[minIdx]
            oriArr[minIdx] = temp
        }
        return oriArr
    }

    func insertionSort(oriArr: inout [Int]) -> [Int] {
        
        for i in 1 ..< oriArr.count {
            var j = i - 1
            let current = oriArr[i]
            while j >= 0 && oriArr[j] > current {
                oriArr[j + 1] = oriArr[j]
                j -= 1
            }
            oriArr[j + 1] = current
        }
        return oriArr
    }
    
    
    func mergeSort(oriArr: inout [Int]) {
        var tempArr = Array.init(repeating: 0, count: oriArr.count)
        sort(arr: &oriArr, left: 0, right: oriArr.count - 1, temp: &tempArr)
    }
    
    func sort(arr: inout [Int], left: Int, right: Int, temp: inout [Int]) {
        if left < right {
            let mid = (left + right) / 2
            sort(arr: &arr, left: left, right: mid, temp: &temp)
            merge()
        }
    }
    
    func merge() {
        print("111")
    }
    
}

