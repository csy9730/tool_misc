# MPII

MPII Human Pose Dataset
[http://human-pose.mpi-inf.mpg.de/](http://human-pose.mpi-inf.mpg.de/)


## download

[ Images (12.9 GB)](https://datasets.d2.mpi-inf.mpg.de/andriluka14cvpr/mpii_human_pose_v1.tar.gz)

[ Annotations (12.5 MB)](https://datasets.d2.mpi-inf.mpg.de/andriluka14cvpr/mpii_human_pose_v1_u12_2.zip)


``` bash
wget -c https://datasets.d2.mpi-inf.mpg.de/andriluka14cvpr/mpii_human_pose_v1_u12_2.zip
wget -c https://datasets.d2.mpi-inf.mpg.de/andriluka14cvpr/mpii_human_pose_v1.tar.gz
```

## arch

```
${POSE_ROOT}
|-- mpii
    `-- |-- annot
        |   |-- gt_valid.mat
        |   |-- test.json
        |   |-- train.json
        |   |-- trainval.json
        |   `-- valid.json
        `-- images
            |-- 000001163.jpg
            |-- 000003072.jpg
```            
## misc
### Annotation description

Annotations are stored in a matlab structure `RELEASE` having following fields

- `.annolist(imgidx)` - annotations for image `imgidx`

  - `.image.name` - image filename

  - ```
    .annorect(ridx)
    ```

     

    \- body annotations for a person

     

    ```
    ridx
    ```

    - `.x1, .y1, .x2, .y2` - coordinates of the head rectangle

    - `.scale` - person scale w.r.t. 200 px height

    - `.objpos` - rough human position in the image

    - ```
      .annopoints.point
      ```

       

      \- person-centric body joint annotations

      - `.x, .y` - coordinates of a joint
      - `id` - joint id (0 - r ankle, 1 - r knee, 2 - r hip, 3 - l hip, 4 - l knee, 5 - l ankle, 6 - pelvis, 7 - thorax, 8 - upper neck, 9 - head top, 10 - r wrist, 11 - r elbow, 12 - r shoulder, 13 - l shoulder, 14 - l elbow, 15 - l wrist)
      - `is_visible` - joint visibility

  - `.vidx` - video index in `video_list`

  - `.frame_sec` - image position in video, in seconds

- `img_train(imgidx)` - training/testing image assignment

- `single_person(imgidx)` - contains rectangle id `ridx` of *sufficiently separated* individuals

- `act(imgidx)` - activity/category label for image `imgidx`

  - `act_name` - activity name
  - `cat_name` - category name
  - `act_id` - activity id

- `video_list(videoidx)` - specifies video id as is provided by YouTube. To watch video on youtube go to <https://www.youtube.com/watch?v=video_list(videoidx>)