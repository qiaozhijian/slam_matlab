function [outputArg1] = selectMode(mode)
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
if mode=="mode1"
    rmpath([pwd '\lineSLAM\Opti\Opti2'])
    rmpath([pwd '\lineSLAM\Opti\Opti3'])
    rmpath([pwd '\lineSLAM\Opti\Opti4'])
    addpath([pwd '\lineSLAM\Opti\Opti1'])
elseif mode=="mode2"
    rmpath([pwd '\lineSLAM\Opti\Opti1'])
    rmpath([pwd '\lineSLAM\Opti\Opti3'])
    rmpath([pwd '\lineSLAM\Opti\Opti4'])
    addpath([pwd '\lineSLAM\Opti\Opti2'])
elseif mode=="mode3"
    rmpath([pwd '\lineSLAM\Opti\Opti1'])
    rmpath([pwd '\lineSLAM\Opti\Opti2'])
    rmpath([pwd '\lineSLAM\Opti\Opti4'])
    addpath([pwd '\lineSLAM\Opti\Opti3'])
elseif mode=="mode4"
    rmpath([pwd '\lineSLAM\Opti\Opti1'])
    rmpath([pwd '\lineSLAM\Opti\Opti3'])
    rmpath([pwd '\lineSLAM\Opti\Opti2'])
    addpath([pwd '\lineSLAM\Opti\Opti4'])
end
end

