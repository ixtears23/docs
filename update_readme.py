import os

# README 파일을 생성할 디렉토리를 지정합니다.
project_dir = '.'

# 프로젝트의 폴더명을 가져와 제목으로 설정합니다.
project_title = os.path.basename(os.path.abspath(project_dir))

# README.md 파일을 쓰기 모드로 엽니다.
with open('README.md', 'w') as readme_file:
    # 프로젝트의 타이틀을 작성합니다.
    readme_file.write(f'# {project_title}\n\n')

    # project_dir에서 모든 파일과 디렉토리를 나열합니다.
    for foldername, subfolders, filenames in os.walk(project_dir):

        # /img로 끝나는 디렉토리와 .idea 및 .git으로 시작하는 디렉토리는 건너뜁니다.
        if foldername.endswith('/img') or foldername.startswith('./.idea') or foldername.startswith('./.git'):
            continue

        # 각 폴더에 대해 섹션 헤더를 추가합니다.
        if foldername != '.':
            clean_foldername = foldername.replace('./', '', 1)  # "./" 제거
            readme_file.write(f'## {clean_foldername}\n\n')

        # 각 파일에 대한 리스트 항목을 추가합니다.
        for filename in filenames:
            if filename != 'README.md' and not filename.lower().endswith('.gif'):
                clean_path = os.path.join(foldername, filename).replace('./', '', 1)  # "./" 제거
                url_encoded_path = clean_path.replace(' ', '%20')  # 띄어쓰기를 %20으로 변환
                readme_file.write(f'- [{filename}]({url_encoded_path})\n')

        # 서브 폴더 리스트가 비어 있지 않으면 추가 공백 라인을 삽입합니다.
        if subfolders:
            readme_file.write('\n')

print('README.md has been created!')
