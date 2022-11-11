function images = loadFiles(imagefiles)
% loadFiles
% it loads files.

nfiles = length(imagefiles);

for ii=1:nfiles
   currentfilename = "DB1/" + imagefiles(ii).name;
   image = imread(currentfilename);
   images{ii} = image;
end

end

