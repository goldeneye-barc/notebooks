%% Read ROS Files
r44 = rosbag('2016-02-18-14-10-44.bag');
r29 = rosbag('2016-02-18-14-14-29.bag');
%% /scan Topic
ML44 = r44.MessageList(:,3);
bagselect44_scan = select(r44,'Topic', '/scan');
scanmsgs = readMessages(bagselect44_scan)
ts_scan = [];
for i = length(scanmsgs)
    for j = 1:360
        while scanmsgs{i,:}.Ranges(j) ~= Inf
            ts_scan(i,j)=scanmsgs{i,:}.Ranges(j)
        end
    end
end
%ts_scan = timeseries(bagselect44_scan, 'Ranges')

%ts_scan = timeseries(bagselect44_scan, 'Ranges', linspace('AngleMin','AngleMax','AngleIncrement'))

%% /hedge_pos_a Topic

bagselect44_hedgepos = select(r44,'Topic', '/hedge_pos_a')
posmsgs = readMessages(bagselect44_hedgepos)

%% /image_raw Topic

bagselect44_imgraw = select(r44, 'Topic', '/image_raw')
imgmsgs = readMessages(bagselect44_imgraw)