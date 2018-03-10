function [PathXs,PathYs] = PlannerOuter(X0,Y0,Psi0,ObstacleXs,ObstacleYs,goalX,goalY)
PathXs = [];
PathYs = [];
Nobs = length(ObstacleXs);
for i = 1:Nobs
    [PathX,PathY, PathPsi] = PlannerInner(X0,Y0,Psi0,ObstacleXs(i),ObstacleYs(i),goalX,goalY);
    PathXs = [PathXs,PathX];
    PathYs = [PathYs,PathY];
    X0 = PathX;
    Y0 = PathY;
    Psi0 = PathPsi;
end
PathXs = [PathXs,goalX];
PathYs = [PathYs,goalY];

end