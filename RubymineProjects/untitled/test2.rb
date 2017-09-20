public def myall
    result=true
    each do |e|
      result=yield(e)
      if result==false
        return result
      end
    end
    result
end

public def myany
  result=false
  each do |e|
    result=yield(e)
    if result==true
      return result
    end
  end
  result
end

public def mychunk
  result1=yield first
  arr=Array.new
  arr1=Array.new
  each do |e|
    result2=yield e
    if result1==result2
      arr1<<e
    else
      arr<<[result1,Array.new(arr1)]
      arr1.clear
      arr1<<e
      result1=result2

    end
  end

  arr<<[result1,Array.new(arr1)]
  arr

end

public def mychunk_while
  flag=true
  flag2=0
  arr=Array.new
  arr1=Array.new
  each_cons(2) do |i,next_i|
    flag2=yield i,next_i
    if flag2==true
      arr1<<i
      flag=false
    elsif flag==true
      arr1<<i
      flag=false

    else
      arr<<Array.new(arr1)
      arr1.clear
      arr1<<i
      flag=flag2
    end
  end

  if flag2==false
    arr<<Array.new(arr1)
    arr1.clear
  end

  arr1<<last
  arr<<Array.new(arr1)
  arr
end


public def mycount(n=nil)
  length = 0
  if n.nil?
    each do |e|
      unless block_given?
        length=length+1
      else
        if (yield e) == true
          length=length+1
        end
      end
    end
  else
    each do|e|
      length=length+1
      if length==n
        return e
      end
    end

  end
  length
end

public def mycollect
  arr=Array.new
  each do|e|
    tmp = yield e
    arr << tmp
    puts arr
  end
  arr
end

public def mycollect_concat
  arr=Array.new
  each do |e|
    tmp =yield e
    until tmp.empty?
      arr<<tmp.shift
    end
  end
  arr
end

public def mycycle(n=nil)
  arr=Array.new
  if n.nil?
    whlie true do
      each do |e|
        yield e
      end
    end

  else
    n.times do |i|
      each do |e|
        yield e
      end
    end

  end
end

public def mydetect
  each do |e|
    if (yield e) ==true
      return e
    end
  end
  nil
end

public def mydrop(n)
  arr=Array.new
  length=0
  each do |e|
    if length>=n
      arr<<e
    end
    length=length+1
  end
  arr
end

public def mydrop_while
  unless block_given?
    return
  end
  arr=Array.new
  length=0
  flag=0
  each do |e|
    if (yield e) ==true &&flag==0
      length=length+1
    else
      flag=1
      arr<<e
      length=length+1
    end

  end
  arr
end

public def myeach_cons(n)
  arr=Array.new
  result=Array.new
  each do |e|
    arr<<e
  end

  length=0

  while length<=(arr.length-n) do
    i=length
    j=0
    tmp=Array.new
    while j<n do
      tmp<<arr[i]
      i+=1
      j+=1
    end
    result<<Array.new(tmp)
    tmp.clear
    length+=1
  end
  result
end

public def myeach_entry
  each do|e|
    yield e
  end
end

public def myeach_slice(n)
  arr=Array.new
  result=Array.new
  each do |e|
    arr<<e
  end

  length=0
  while length<arr.length do
    i=0
    tmp=Array.new
    while i<n && length<arr.length
      tmp<<arr[length]
      i+=1
      length+=1
    end
    result<<Array.new(tmp)
  end
  result
end


public def myeach_with_index
  arr=Array.new
  each do |e|
    arr<<e
  end

  length=0
  arr.each do|x|
    yield x,length
    length+=1
  end

end

public def myeach_with_object(object)
  a=Array.new
  each do |e|
    yield e,a
  end
  a
end

public def myfind
  each do |e|
    if (yield e) ==true
      return e
    end
  end
  nil
end

public def myfind_all
  a=Array.new
  each do |e|
    if (yield e) ==true
      a<< e
    end
  end
  a
end

public def myfirst
  found = nil
  each do |e|
    found=e
    break
  end
  found
end

public def myfind_index
  length=0
  each do |e|
    if (yield e) ==true
      return length
    end
    length+=1
  end
  nil
end

public def myflat_map
  result=Array.new
  arr=Array.new
  arr1=Array.new
  each do |e|
    arr<< (yield e)
    arr1=arr[0]
    i=0
    while i<arr1.length do
      result<<arr1[i]
      i+=1
    end
    arr.clear
    arr1.clear
  end
  result
end

public def mygrep(n)
  arr=Array.new
  each do |e|
    if  e == n
      if block_given?
        arr<<(yield e)
      else
        arr<<e
      end
    end
  end
  arr
end

public def mygrep_v(n)
  arr=Array.new
  each do |e|
    if  e != n
      if block_given?
        arr<<(yield e)
      else
        arr<<e
      end

    end
  end
  arr

end

public def mygroup_by #24
  hash=Hash.new
  arr=Array.new
  arr1=Array.new
  each do |e|
    arr<<e
  end

  while arr.length>0 do
    length=0
    result1=yield arr[length]
    while length<arr.length do
      if (yield arr[length])==result1
        arr1<<arr.delete_at(length)
        length=length-1
      end
      length=length+1
    end
    hash[result1]=Array.new(arr1)
    arr1.clear

  end
  hash
end

public def myinclude?(obj)
  each do |e|
    if e==obj
      return true
    end

  end
  false
end

public def myinject(accumulator=nil)
  if accumulator.nil?
    ignore_first=true
    accumulator=first
  end
  is_first=true
  each do |e|
    unless is_first && ignore_first
      accumulator=yield(accumulator,e)
    end
    is_first=false
  end
  accumulator
end

public def mylazy
  arr=Array.new
  each do |e|
    arr<<e
  end
  arr
end

public def mymap
  arr=Array.new
  each do |e|
    arr<<(yield e)
  end
  arr
end

public def mymax(n=nil)
  if n.nil?
    myinject{|accumulator,element|accumulator > element ? accumulator:element}
  else
    arr1=Array.new(n)
      each do |e|
        length=0
        while length<n  do
          if arr1[length]==nil or e>arr1[length]
            i=1
            while n-i>length do
              arr=Array.new(arr1)
              arr1[n-i]=arr[n-i-1]
              i+=1
            end
            arr1[length]=e
            break
          end
          length+=1

        end
      end
    arr1
  end

end

public def mymax_by(n=nil)
  if n.nil?
    myinject{|accumulator,element|(yield accumulator) >= (yield element) ? accumulator:element}
  else
    arr1=Array.new(n)
    each do |e|
      length=0
      while length<n  do
        if arr1[length]==nil or ((yield e)>(yield arr1[length]))
          i=1
          while n-i>length do
            arr=Array.new(arr1)
            arr1[n-i]=arr[n-i-1]
            i+=1
          end
          arr1[length]=e
          break
        end
        length+=1

      end
    end
    arr1
  end
end

public def mymin(n=nil)
  if n.nil?
    myinject{|accumulator,element|accumulator < element ? accumulator:element}
  else
    arr1=Array.new(n)
    each do |e|
      length=0
      while length<n  do
        if arr1[length]==nil or e<arr1[length]
          i=1
          while n-i>length do
            arr=Array.new(arr1)
            arr1[n-i]=arr[n-i-1]
            i+=1
          end
          arr1[length]=e
          break
        end
        length+=1

      end
    end
    arr1
  end
end

public def mymin_by(n=nil)
  if n.nil?
    myinject{|accumulator,element|(yield accumulator) <= (yield element) ? accumulator:element}
  else
    arr1=Array.new(n)
    each do |e|
      length=0
      while length<n  do
        if arr1[length]==nil or ((yield e)<(yield arr1[length]))
          i=1
          while n-i>length do
            arr=Array.new(arr1)
            arr1[n-i]=arr[n-i-1]
            i+=1
          end
          arr1[length]=e
          break
        end
        length+=1

      end
    end
    arr1
  end
end

public def mymember(n)
  each do |e|
    if e==n
      return true
    end

  end
  false
end


public def myminmax
  min=first
  max=first
  each do |e|
    if e>max
      max=e
    elsif e<min
      min=e
    end

  end
  [min,max]
end

public def mynone
  each do |e|
    if  (yield e)==true
      return false
    end

  end
  true
end

public def myminmax_by
  min=first
  max=first
  each do |e|
    if (yield e)>(yield max)
      max=e
    elsif (yield e)<(yield min)
      min=e
    end

  end
  [min,max]
end

public def myone
  result=0
  each do |e|
    if (yield e) ==true
      result+=1
    end
  end
  if result==1
      return true
  end
  return false
end

public def myreduce(*argv, &block)
  initial=nil
  sym=nil
  if argv[0].is_a?(Numeric)
    initial=argv[0]
  elsif argv[0].nil? == false
    sym=argv[0]
  end

  unless argv[1].nil?
    sym=argv[1]
  end

  if sym==nil
    if initial.nil?
      ignore_first=true
      initial=first
    end
    is_first=true
    each do |e|
      unless is_first && ignore_first
        initial=yield(initial,e)
      end
      is_first=false
    end
  else
    if initial.nil?
      ignore_first=true
      initial=first
    end
    is_first=true
    each do |e|
      unless is_first && ignore_first
        if sym.to_s=='+'
          initial=initial+e
        elsif sym.to_s=='*'
          initial=initial*e
        elsif sym.to_s=='-'
          initial=initial-e
        elsif sym.to_s=='/'
          initial=initial/e
        end

      end
      is_first=false
    end
    initial
  end
end

public def mypartition
  arr=Array.new
  each do |e|
    arr<<e
  end
  length=0
  arr1=Array.new
  result=Array.new
  while length<arr.length do
    if (yield (arr[length]))==true
      arr1<<arr.delete_at(length)
    else
      length+=1
    end
  end
  result<<Array.new(arr1)
  arr1.clear
  length=0
  while arr.length>0 do
    arr1<<arr.delete_at(length)
  end
  result<<Array.new(arr1)
  result
end

public def myreject
  arr=Array.new
  each do |e|
    if (yield e)==false
      arr<<e
    end
  end
  arr
end

public def myreverse_each
  arr=Array.new
  arr_r=Array.new
  each do |e|
    arr<<e
  end
  while arr.length>0
    arr_r<<arr.pop
  end
  arr_r

end

public def myselect
  arr=Array.new
  each do |e|
    if (yield e)==true
      arr<<e
    end
  end
  arr
end

public def myslice_after(n)
  flag=0
  arr=Array.new
         result=Array.new
         each do|e|
           if flag==0 && e!=n
             arr<<e
           elsif e==n
             flag=1
             arr<<e
             result<<Array.new(arr)
             arr.clear
           else
             arr<<e
           end
         end
         result<<Array.new(arr)
         result
end

public def myslice_before(n)
  flag=0
  arr=Array.new
  result=Array.new
  each do|e|
    if flag==0 && e!=n
      arr<<e
    elsif e==n
      result<<Array.new(arr)
      arr.clear
      flag=1
      arr<<e
    else
      arr<<e
    end
  end
  result<<Array.new(arr)
  result
end

public def myslice_when
  flag=0
  arr=Array.new
  result=Array.new
  each do|e|
    if (flag==0) && ((yield e)!=true)
      arr<<e
    elsif yield e
      flag=1
      arr<<e
      result<<Array.new(arr)
      arr.clear
    else
      arr<<e
    end
  end
  result<<Array.new(arr)
  result
end

public def mysort
  arr=Array.new
  each do |e|
    arr<<e
  end
  i=0
  while i<arr.length-1 do
    j=i
    while j<arr.length-1 do
      if arr[j]>arr[j+1]
        tmp=arr[j]
        arr[j]=arr[j+1]
        arr[j+1]=tmp
      end
      j+=1
    end
    i+=1
  end

  arr
end




public def mysort_by
  arr=Array.new
  each do |e|
    arr<<e
  end
  i=0
  while i<arr.length-1 do
    j=i
    while j<arr.length-1 do
      if (yield arr[j])>(yield arr[j+1])
        tmp=arr[j]
        arr[j]=arr[j+1]
        arr[j+1]=tmp
      end
      j+=1
    end
    i+=1
  end

  arr
end

public def mysum
  myinject{|accumulator,element|accumulator = accumulator+element}
end

public def mytake(n)
  arr=Array.new
  i=0
  each do |e|
    if i<n
      arr<<e
      i+=1
    end
  end
  arr
end

public def mytake_while
  arr=Array.new
  each do |e|
    if yield e
      arr<<e
    end
  end
  arr
end

public def myuniq
  arr=Array.new
  each do |e|
    arr<<e
  end
  i=0
  while i<arr.length-1 do
    j=i+1
    while j<arr.length do
      if arr[i]==arr[j]
        arr.delete_at(j)
      else
        j+=1
      end
    end
    i+=1
  end

  arr
end

public def myzip(arr)
  arr1=Array.new
  length=0
  each do |e|
    arr1<<[e,arr[length]]
    length+=1
  end
  arr1
end

public def myto_h
  arr=Array.new
  each do |e|
    arr<<e
  end
  length=0
  hash=Hash.new
  while length<arr.length
    hash[arr[length]]=length
    length+=1
  end

  hash
end