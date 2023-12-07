import cv2
import torch

print(f'torch.__version__ = {torch.__version__}')
print(f'torch.cuda.is_available() = {torch.cuda.is_available()}')
print(f'torch.cuda.device_count() = {torch.cuda.device_count()}')
print(f'cv2.cuda.getCudaEnabledDeviceCount() = {cv2.cuda.getCudaEnabledDeviceCount()}')

cv2.cuda.setDevice(0)

test_video_url = 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_5mb.mp4'
cap = cv2.cudacodec.createVideoReader(test_video_url)
ret, frame = cap.nextFrame()
print(f'frame.size() = {frame.size()}')
